module ReplyHelper
  def status_options
    Reply.statuses.reduce({}) do |memo, (enum, _)|
      translated_enum = I18n.t("reply_status.#{enum}")
      memo[translated_enum] = enum
      memo
    end
  end

  def reply_for(event, user)
    Reply.for_event_and_user(event, user)
  end

  # TODO: Please refactor me, I'm so ugly!
  def waiting_position_for(event, user)
    waiting_user_ids = Reply.where(event_id: event).waiting
      .order('updated_at').pluck(:user_id)

    position = waiting_user_ids.index(user.id)
    return nil unless position
    position + 1
  end
end
