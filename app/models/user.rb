class User < ActiveRecord::Base
  has_one :user_profile, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  after_create :create_user_profile

  scope :players, -> { where(player: true) }
  scope :player_pass, -> (boolean) { where(player_pass: boolean) }

  def self.players_for_event(event_id)
    club_team_id = Event.find(event_id).club_team_id
    player_pass_needed = Team.find(club_team_id).player_pass_needed?
    players.player_pass(player_pass_needed)
  end

  def self.pending_players_for_event(event_id)
    players_for_event(event_id)
      .where.not(id: Reply.event(event_id).pluck(:user_id))
  end

  # NOTE: Workaround to migrate users from legacy app
  # Following: https://vesselinv.com/rails-devise-user-migration-legacy-apps/
  def valid_password?(password)
    if legacy_password?
      # Use Devise's secure_compare to avoid timing attacks
      return false unless Devise.secure_compare(self.encrypted_password,
                                                User.legacy_password(password))

      self.attributes = { password:              password,
                          password_confirmation: password,
                          legacy_password:       false }

      self.save!
    end

    super password
  end

  # NOTE: Workaround to migrate users from legacy app
  # Following: https://vesselinv.com/rails-devise-user-migration-legacy-apps/
  def self.legacy_password(password)
    Digest::MD5.hexdigest(password)
  end

  private

  def create_user_profile
    UserProfile.create(user: self, alias: username.titleize)
  end
end
