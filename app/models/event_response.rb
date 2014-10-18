class EventResponse
  has_one :user
  has_one :event

  validates :user_id, :event_id, :status

  enum status: %i(yes no maybee watch)
end
