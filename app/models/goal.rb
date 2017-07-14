class Goal < ApplicationRecord
  belongs_to :event
  belongs_to :scorer, class_name: 'Player', optional: true
  belongs_to :provider, class_name: 'Player', optional: true
  belongs_to :reporter, class_name: 'Player'

  validates :club_score, :minute, :rival_score, presence: true
end
