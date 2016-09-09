class Player < ApplicationRecord
  include FriendlyId

  mount_uploader :avatar, AvatarUploader unless Rails.env.test?

  has_one :address, through: :member
  has_one :contact, through: :member
  belongs_to :member

  has_many :attendances, dependent: :destroy
  has_and_belongs_to_many :teams

  validates :nickname, presence: true
  validates :jersey_number, uniqueness: true, allow_nil: true
  delegate :club_email, to: :contact
  delegate :phone1, :phone2, to: :contact

  enum status: { active: 0, injured: 1, inactive: 2 }

  friendly_id :nickname, use: :slugged

  paginates_per 12

  scope :player_pass, -> (needed) { where(player_pass: true) if needed }

  delegate :club_email, to: :contact

  def club_email_with_nickname
    %("#{nickname}" <#{club_email}>)
  end
end
