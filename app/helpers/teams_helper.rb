module TeamsHelper
  def grouped_team_options
    [
      ['Aktuelle Saison', Team.rivals.current_season(true).pluck(:name, :id)],
      ['Andere', Team.rivals.current_season(false).pluck(:name, :id)]
    ]
  end
end
