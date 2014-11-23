class Event < ActiveRecord::Base
  has_many :event_responses

  validates :name, :datetime, presence: true

  def yes_count
    event_responses.yes.count
  end
end
