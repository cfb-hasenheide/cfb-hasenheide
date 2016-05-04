class Player < ActiveRecord::Base
  belongs_to :user
  has_many :attendances, dependent: :destroy

  validates :nickname, :user_id, presence: true
  validates :jersey_number, uniqueness: true, allow_nil: true
  validates :user_id, uniqueness: true

  enum status: { active: 0, injured: 1, inactive: 2 }

  paginates_per 12

  scope :active, -> { where(member_until: nil) }
  scope :player_pass, -> (needed) { where(player_pass: true) if needed }

  def club_email_with_nickname
    %("#{nickname}" <#{club_email}>)
  end
end
