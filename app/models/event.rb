class Event < ActiveRecord::Base
  has_one :list

  validates :name, :datetime, presence: true

  accepts_nested_attributes_for :list
end
