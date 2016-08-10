class LeagueMatch < Event
  include FriendlyIdAble

  belongs_to :rival_team, class_name: 'Team'

  validates :club_team_id, :rival_team_id, presence: true

  validates :home, inclusion: { in: [true, false] }
  validates :home, exclusion: { in: [nil] }

  # NOTE: Make sure to prepend it so that it runs before Friendly_id's own
  # callback: http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  before_validation :generate_name, prepend: true

  def generate_name
    return unless club_team_id? && rival_team_id?

    self.name = if home?
                  club_team.name + ' : ' + rival_team.name
                else
                  rival_team.name + ' : ' + club_team.name
                end
  end
end
