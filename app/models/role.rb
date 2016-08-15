class Role < ApplicationRecord
  has_many :functions
  has_many :players, through: :functions

  validates :name, presence: true, uniqueness: true
end
