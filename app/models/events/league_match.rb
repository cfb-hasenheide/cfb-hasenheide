class LeagueMatch < Event
  include FriendlyIdAble

  validates :club_team_id, :rival_team_id, presence: true

  validates :home, inclusion: { in: [true, false] }
  validates :home, exclusion: { in: [nil] }

  before_save :generate_name

  def generate_name
    self.name = if home?
                  club_team.name + ' : ' + rival_team.name
                else
                  rival_team.name + ' : ' + club_team.name
                end
  end
end
