class Event < ActiveRecord::Base
  has_many :replies

  enum kind: { home: 0, away: 1, cup: 2, tournament: 3, friendly: 4, other: 5 }

  validates :kind, :name, :datetime, presence: true

  # TODO translate in local yml
  KINDS = { home: 'Heimspiel Liga',
            away: 'Auswärtsspiel Liga',
            cup: 'Pokalspiel',
            tournament: 'Turnier',
            friendly: 'Freundschaftsspiel',
            other: 'Sonstiges' }

  scope :upcoming, -> { where('datetime >= ?', Time.now).order('datetime DESC') }
  scope :past,     -> { where('datetime < ?', Time.now).order('datetime DESC') }

  def yes_count
    replies.yes.count
  end

  def humanized_kind
    Event::KINDS[kind.to_sym]
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
end
