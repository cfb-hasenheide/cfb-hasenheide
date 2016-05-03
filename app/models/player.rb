class Player < ActiveRecord::Base
  belongs_to :user

  validates :nickname, :user_id, presence: true
  validates :jersey_number, uniqueness: true, allow_nil: true
  validates :user_id, uniqueness: true

  paginates_per 12
end
