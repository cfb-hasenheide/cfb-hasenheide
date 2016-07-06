class Player < ActiveRecord::Base
  include FriendlyId

  mount_uploader :avatar, AvatarUploader

  belongs_to :user
  has_many :attendances, dependent: :destroy

  validates :nickname, :user_id, presence: true
  validates :jersey_number, uniqueness: true, allow_nil: true
  validates :user_id, uniqueness: true

  enum status: { active: 0, injured: 1, inactive: 2 }

  friendly_id :nickname, use: :slugged

  paginates_per 12

  scope :player_pass, -> (needed) { where(player_pass: true) if needed }

  def club_email_with_nickname
    %("#{nickname}" <#{club_email}>)
  end
end
