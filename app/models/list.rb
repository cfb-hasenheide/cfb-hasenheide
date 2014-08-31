class List < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :users, as: :ins
  has_and_belongs_to_many :users, as: :outs
  has_and_belongs_to_many :users, as: :waitees
  has_and_belongs_to_many :users, as: :maybees

  validates :minimum, :maximum, presence: true
end
