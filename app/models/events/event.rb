class Event < ActiveRecord::Base
  include FriendlyIdAble

  paginates_per 12

  has_one :attendance_list, as: :attendable, dependent: :destroy
  has_many :attendances, through: :attendance_list
  has_one :report, dependent: :destroy
  belongs_to :club_team,  class_name: 'Team'
  belongs_to :rival_team, class_name: 'Team'

  accepts_nested_attributes_for :attendance_list

  validates :address,
            :datetime,
            :name,
            :type,
            presence: true

  scope :future, lambda { |limit = nil|
    where('datetime >= ?', Time.zone.now).order('datetime DESC').limit(limit)
  }
  scope :past, lambda { |limit = nil|
    where('datetime < ?', Time.zone.now).order('datetime DESC').limit(limit)
  }

  delegate :future?, :past?, to: :datetime
  delegate :name, to: :club_team, prefix: true
  delegate :name, to: :rival_team, prefix: true
  delegate :open?, to: :attendance_list, prefix: true, allow_nil: true
  delegate :player_pass_needed?, to: :club_team
  delegate :final_score, :lost?, :won?, to: :report, allow_nil: true

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

  def eligible_players
    Player.active.player_pass(player_pass_needed?)
  end

  def attending_players
    player_ids = attendances.where(status: [1, 2])
                            .order(:status, :updated_at)
                            .limit(attendance_list.maximum)
                            .pluck(:player_id)

    Player.where(id: player_ids).order(:nickname)
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
