class AttendanceList < ApplicationRecord
  belongs_to :attendable, polymorphic: true
  has_many :attendances, dependent: :destroy

  validates :minimum,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: :maximum }

  validates :maximum,
            presence: true,
            numericality: { greater_than: :minimum }

  delegate :eligible_players, to: :attendable

  def yes_and_waiting_quota
    yes_and_waiting_count.to_f / maximum
  end

  def yes_and_waiting_count
    yes_count + waiting_count
  end

  def yes_count
    attendances.yes.count
  end

  def waiting_count
    attendances.waiting.count
  end

  def open!
    return false if open?

    ActiveRecord::Base.transaction do
      player_ids = eligible_players.pluck(:id) - attendances.pluck(:player_id)

      player_ids.each do |player_id|
        attendances.create!(player_id: player_id, status: :pending)
      end

      update!(open: true)
    end
  end

  def close!
    return false unless open?

    ActiveRecord::Base.transaction do
      attendances.pending.destroy_all

      update!(open: false)
    end
  end
end
