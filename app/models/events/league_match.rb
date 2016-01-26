class LeagueMatch < Event
  validates :club_team_id, :rival_team_id, presence: true

  validates :home, inclusion: { in: [true, false] }
  validates :home, exclusion: { in: [nil] }

  def name
    if home?
      club_team.name + ' : ' + rival_team.name
    else
      rival_team.name + ' : ' + club_team.name
    end
  end
end
