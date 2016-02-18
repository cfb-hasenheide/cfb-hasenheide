module ReplyHelper
  def status_options
    Reply.statuses.each_with_object({}) do |(enum, _), options|
      translated_enum = I18n.t("reply_status.#{enum}")
      options[translated_enum] = enum
    end
  end

  # TODO: Please refactor me, I'm so ugly!
  def waiting_position_for(event, user)
    waiting_user_ids = Reply.where(event_id: event)
                            .waiting
                            .order('updated_at')
                            .pluck(:user_id)

    position = waiting_user_ids.index(user.id)
    return nil unless position
    position + 1
  end
end
