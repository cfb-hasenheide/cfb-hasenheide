class Event < ActiveRecord::Base
  before_save :convert_to_datetime

  has_many   :replies,    dependent: :destroy
  has_one    :report,     dependent: :destroy
  belongs_to :club_team,  class_name: 'Team'
  belongs_to :rival_team, class_name: 'Team'

  enum kind: { league: 0, cup: 1, tournament: 2, friendly: 3, other: 4 }

  # TODO: Validate name unless rival_team_id.present?
  validates :kind, :datetime, :club_team_id, presence: true
  validates :name, presence: true, unless: "rival_team_id.present?"
  validates :minimum,
    numericality: { greater_than: 0, less_than_or_equal_to: :maximum }
  validates :maximum, numericality: { less_than_or_equal_to: User.count }

  validates :home, inclusion: { in: [true, false] }
  validates :home, exclusion: { in: [nil] }

  scope :upcoming, -> { where('datetime >= ?', Time.now).order('datetime ASC') }
  scope :past,     -> { where('datetime < ?', Time.now).order('datetime DESC') }

  def past?
    datetime < Time.now
  end

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
    return name if name.present?
    if home?
      club_team.name + ' : ' + rival_team.name
    else
      rival_team.name + ' : ' + club_team.name
    end
  end

  # NOTE: Virtual attributes for datetime input fields

  def datetime_date
    datetime.strftime("%d.%m.%Y") if datetime.present?
  end

  def datetime_time
    datetime.strftime("%H:%M") if datetime.present?
  end

  def datetime_date=(date)
    # Change back to datetime friendly format
    @datetime_date = Date.parse(date).strftime("%d.%m.%Y")
  end

  def datetime_time=(time)
    # Change back to datetime friendly format
    @datetime_time = Time.parse(time).strftime("%H:%M:%S %Z")
  end

  def convert_to_datetime
    self.datetime = DateTime.parse("#{@datetime_date} #{@datetime_time}")
  end

  # NOTE: End of Virtual attributes for datetime input fields
end
