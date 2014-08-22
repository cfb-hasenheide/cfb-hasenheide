class Event < ActiveRecord::Base
  has_many :entry_lists

  validates :name, :datetime, presence: true
end
