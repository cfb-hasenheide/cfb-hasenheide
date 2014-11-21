class Event < ActiveRecord::Base
  has_many :event_responses

  validates :name, :datetime, presence: true

  def attendees
    event_responses.yes.pluck(:user_id).map do |user_id|
      User.find(user_id)
    end
  end

  def maybees
  end

  def waitess
  end
end
