class User < ActiveRecord::Base
  has_one :user_profile, dependent: :destroy
  has_one :player, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

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

  # NOTE: Workaround to let users with legacy password reset their password
  # https://github.com/plataformatec/devise/wiki/How-To:-Migration-legacy-database
  def reset_password(*args)
    self.legacy_password = false
    super
  end
end
