class Event < ActiveRecord::Base
  validates :name, :datetime, presence: true
end
