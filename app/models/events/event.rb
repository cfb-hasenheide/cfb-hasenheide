class Event < ActiveRecord::Base
  include Replyable
  include FriendlyIdAble

  paginates_per 12

  has_one :report, dependent: :destroy
  belongs_to :club_team,  class_name: 'Team'
  belongs_to :rival_team, class_name: 'Team'

  validates :address,
            :datetime,
            :maximum,
            :minimum,
            :name,
            :type,
            presence: true

  validates :minimum,
            numericality: { greater_than: 0, less_than_or_equal_to: :maximum }
  validates :maximum, numericality: { greater_than: :minimum }

  scope :future, lambda { |limit = nil|
    where('datetime >= ?', Time.zone.now).order('datetime ASC').limit(limit)
  }
  scope :past, lambda { |limit = nil|
    where('datetime < ?', Time.zone.now).order('datetime DESC').limit(limit)
  }

  delegate :future?, :past?, to: :datetime
  delegate :name, to: :club_team, prefix: true
  delegate :name, to: :rival_team, prefix: true
  delegate :player_pass_needed?, to: :club_team

  def self.without_report
    ids = Report.all.pluck(:event_id)
    where.not(id: ids)
  end

  def self.previous(event_id)
    event = find(event_id)
    rival_team_id = event.rival_team_id
    datetime = event.datetime

    where(rival_team_id: rival_team_id)
      .where.not(id: event_id)
      .where('datetime < ?', datetime)
      .order(datetime: :desc)
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

  def won?
    return false unless report.present? && report.final_score_present?
    report.club_final_score > report.rival_final_score
  end

  def lost?
    return false unless report.present? && report.final_score_present?
    report.club_final_score < report.rival_final_score
  end

  def drawed?
    return false unless report.present? && report.final_score_present?
    report.club_final_score == report.rival_final_score
  end

  def replies_quota
    yes_and_waiting_count.to_f / maximum
  end

  def possible_players
    player_pass_needed = Team.find(club_team_id).player_pass_needed?
    Player.active.player_pass(player_pass_needed)
  end

  def attending_players
    user_ids = Reply.by_event(id)
                    .where(status: [1, 2])
                    .order(:status, :updated_at)
                    .limit(maximum)
                    .pluck(:user_id)

    Player.where(user_id: user_ids).order(:nickname)
  end

  def pending_players
    possible_players.where.not(id: Reply.by_event(id).pluck(:user_id))
  end

  def to_ics
    calendar = Icalendar::Calendar.new
    event = Icalendar::Event.new
    event.dtstart = datetime
    event.duration = 'PT2H0M0S'
    event.summary = name
    event.description = description
    event.location = address
    event.created = created_at
    event.last_modified = updated_at
    event.uid = friendly_id
    calendar.add_event(event)
    calendar.publish
    calendar.to_ical
  end
end
