class User < ApplicationRecord
  has_one :player, dependent: :destroy
  has_one :member
  has_one :address, as: :addressable
  has_one :contact, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  delegate :street, :zipcode, :city, to: :address

  has_many :functions
  has_many :roles, through: :functions

  def self.without_player
    User.where.not(id: Player.pluck(:user_id))
  end

  # NOTE: Workaround to migrate users from legacy app
  # https://vesselinv.com/rails-devise-user-migration-legacy-apps/
  def self.legacy_password(password)
    Digest::MD5.hexdigest(password)
  end

  # NOTE: Workaround to migrate users from legacy app
  # https://vesselinv.com/rails-devise-user-migration-legacy-apps/
  def valid_password?(password)
    if legacy_password?
      # Use Devise's secure_compare to avoid timing attacks
      return false unless Devise.secure_compare(encrypted_password,
                                                User.legacy_password(password))

      self.attributes = { password:              password,
                          password_confirmation: password,
                          legacy_password:       false }

      save!
    end

    super password
  end

  def assign_role(role, start = nil, ending = nil)
    functions << Function.create(role_id: role.id,
                                 assumed_at: start,
                                 vacated_at: ending)
    save
  end

  # NOTE: Workaround to let users with legacy password reset their password
  # https://github.com/plataformatec/devise/wiki/How-To:-Migration-legacy-database
  def reset_password(*args)
    self.legacy_password = false
    super
  end

  def current_functions
    functions.where('vacated_at >= ?', DateTime.now)
  end

  def player?
    return true if player
    false
  end
end
