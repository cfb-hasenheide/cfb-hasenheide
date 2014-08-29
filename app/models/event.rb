class Event < ActiveRecord::Base
  has_one :list

  validates :name, :datetime, presence: true
end
