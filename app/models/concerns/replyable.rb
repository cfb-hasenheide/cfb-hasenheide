module Replyable
  extend ActiveSupport::Concern

  included do
    has_many :replies, dependent: :destroy

    def yes_and_waiting_count
      yes_count + waiting_count
    end

    def yes_count
      replies.yes.count
    end

    def waiting_count
      replies.waiting.count
    end

    def open!
      return if replyable?

      ActiveRecord::Base.transaction do
        User.pending_players_for_event(id).pluck(:id).each do |user_id|
          Reply.create!(user_id: user_id, event_id: id, status: :pending)
        end

        update!(replyable: true)
      end
    end

    def close!
      return unless replyable?

      ActiveRecord::Base.transaction do
        Reply.event(id).pending.delete_all

        update!(replyable: false)
      end
    end
  end

  class_methods do
  end
end
