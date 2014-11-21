class Event < ActiveRecord::Base
  has_many :event_responses

  validates :name, :datetime, presence: true
end
