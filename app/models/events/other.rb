class Other < Event
  include FriendlyIdAble

  validates :name, :club_team_id, presence: true
end
