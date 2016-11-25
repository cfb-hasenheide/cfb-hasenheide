class Training < ApplicationRecord
  has_and_belongs_to_many :players
  has_one :address, as: :addressable

  validates :date, presence: true, uniqueness: true
  validates :additional_count, numericality: { greater_than_or_equal_to: 0 }

  def players_count
    players.count + additional_count
  end
end
