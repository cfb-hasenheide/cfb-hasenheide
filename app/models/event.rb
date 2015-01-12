class Event < ActiveRecord::Base
  has_many :replies
  has_one :report

  enum kind: { league: 0, cup: 1, tournament: 2, friendly: 3, other: 4 }

  validates :kind, :datetime, :home_team, :away_team, presence: true
  validates :minimum,
    numericality: { greater_than: 0, less_than_or_equal_to: :maximum }
  validates :maximum, numericality: { less_than_or_equal_to: User.count }

  before_save :set_teams, if: :teams_changed?

  scope :upcoming, -> { where('datetime >= ?', Time.now).order('datetime DESC') }
  scope :past,     -> { where('datetime < ?', Time.now).order('datetime DESC') }

  def yes_count
    replies.yes.count
  end

  def waiting_count
    replies.waiting.count
  end

  def google_maps_url
    "http://maps.google.com/?q=#{address}"
  end

  def google_static_maps_url
    'http://maps.googleapis.com/maps/api/staticmap' \
    "?center=#{address}" \
    "&markers=color:green|#{address}" \
    '&zoom=14' \
    '&size=400x400' \
    '&sensor=false' \
    '&scale=2'
  end

  def generated_name
    "#{home_team} : #{away_team}"
  end

  private

  def set_teams
    self.home_team_id = Team.find_or_create_by(name: home_team.strip).id
    self.away_team_id = Team.find_or_create_by(name: away_team.strip).id
  end

  def teams_changed?
    home_team_changed? || away_team_changed?
  end
end
