module ReplyHelper
  def status_options
    # TODO use i18n translation
    { 'M - Meldung' => 'yes',
      '0 - Absage' => 'no',
      '? - Vielleicht' => 'maybee',
      'Z - Zuschauer' => 'watch' }
  end

  def reply_for(event, user)
    Reply.for_event_and_user(event, user)
  end
end
