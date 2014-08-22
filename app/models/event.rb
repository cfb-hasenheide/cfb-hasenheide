class Event < ActiveRecord::Base
  has_many :entry_lists
end
