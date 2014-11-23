module ReplyHelper
  def status_options
    # TODO use i18n translation
    { 'M - Meldung' => 'yes',
      '0 - Absage' => 'no',
      '? - Vielleicht' => 'maybee',
      'Z - Zuschauer' => 'watch' }
  end

  def reply_for(event, user)
    Reply.by_event_and_user(event, user)
  end

  def reply_status_for(event, user)
    reply_for(event, user).humanized_status
  end
end
