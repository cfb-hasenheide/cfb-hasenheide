class Team < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  scope :club, -> { where(club: true) }
  scope :rivals, -> { where.not(club: true) }
end
