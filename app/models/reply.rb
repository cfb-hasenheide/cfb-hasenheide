class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  # TODO set unique compound index on event, user
  # index :user, :event, unique: true

  validates :user_id, :event_id, :status, presence: true

  enum status: { yes: 0, no: 1, maybee: 2, waiting: 3, watch: 4 }

  # TODO translate in local yml
  STATUSES = { yes: 'M - Meldung',
               no: '0 - Absage',
               maybee: '? - Unsicher',
               waiting: 'W - Warteliste',
               watch: 'Z - Zuschauer' }

  def self.for_event_and_user(event, user)
    find_or_initialize_by(event_id: event, user_id: user)
  end

  def self.by_event_and_status(event, status)
    where(event_id: event).send(status.to_sym)
  end

  def humanized_status
    return 'Ausstehend' unless status
    STATUSES[status.to_sym]
  end
end
