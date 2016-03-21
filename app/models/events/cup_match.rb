class CupMatch < Event
  include FriendlyIdAble

  validates :club_team_id, :rival_team_id, presence: true

  validates :home, inclusion: { in: [true, false] }
  validates :home, exclusion: { in: [nil] }

  before_validation :generate_name, prepend: true

  private

  def generate_name
    self.name = name_order
  end

  def name_order
    if home?
      "#{club_team.name} : #{rival_team.name}"
    else
      "#{rival_team.name} : #{club_team.name}"
    end
  end
end
