class List < ActiveRecord::Base
  belongs_to :event
  has_many :users, as: :ins
  has_many :users, as: :outs
  has_many :users, as: :waitees
  has_many :users, as: :maybees

  validates :minimum, :maximum, presence: true
end
