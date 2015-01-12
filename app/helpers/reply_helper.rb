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
end
