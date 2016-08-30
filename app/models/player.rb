class Player < ApplicationRecord
  include FriendlyId

  mount_uploader :avatar, AvatarUploader unless Rails.env.test?

  delegate :address, to: :member
  delegate :contact, to: :member
  belongs_to :member

  has_many :attendances, dependent: :destroy

  validates :nickname, presence: true
  validates :jersey_number, uniqueness: true, allow_nil: true

  enum status: { active: 0, injured: 1, inactive: 2 }

  friendly_id :nickname, use: :slugged

  paginates_per 12

  scope :player_pass, -> (needed) { where(player_pass: true) if needed }

  def club_email_with_nickname
    %("#{nickname}" <#{club_email}>)
  end
end
