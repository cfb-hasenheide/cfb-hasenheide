class List < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :ins, class_name: 'User'
  has_and_belongs_to_many :outs, class_name: 'User'
  has_and_belongs_to_many :waitees, class_name: 'User'
  has_and_belongs_to_many :maybees, class_name: 'User'

  validates :minimum, :maximum, presence: true
end
