class AttendeesList < ActiveRecord::Base
  validates :minimum,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: :maximum }

  validates :maximum,
            presence: true,
            numericality: { greater_than: :minimum }
end
