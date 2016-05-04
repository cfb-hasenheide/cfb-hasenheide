class AttendanceList < ActiveRecord::Base
  validates :minimum,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: :maximum }

  validates :maximum,
            presence: true,
            numericality: { greater_than: :minimum }

  def pending_players
    possible_players.where.not(id: Reply.by_event(id).pluck(:user_id))
  end

  def open!
    return if open?

    ActiveRecord::Base.transaction do
      pending_players.pluck(:id).each do |user_id|
        Reply.create!(user_id: user_id, event_id: id, status: :pending)
      end

      update!(replyable: true)
    end
  end

  def close!
    return unless open?

    ActiveRecord::Base.transaction do
      Reply.by_event(id).pending.delete_all

      update!(replyable: false)
    end
  end
end
