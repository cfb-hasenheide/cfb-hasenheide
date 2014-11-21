class EventResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  # TODO set unique compound index on event, user
  # index :user, :event, unique: true

  validates :user_id, :event_id, :status, presence: true

  enum status: %i(yes no maybee watch)

  def self.by_event_and_user(event, user)
    where(event_id: event, user_id: user).first
  end
end
