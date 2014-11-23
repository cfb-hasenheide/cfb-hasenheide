module EventResponseHelper
  def status_options
    # TODO use i18n translation
    { 'M - Meldung' => 'yes',
      '0 - Absage' => 'no',
      '? - Vielleicht' => 'maybee',
      'Z - Zuschauer' => 'watch' }
  end

  def event_response_for(event, user)
    EventResponse.by_event_and_user(event, user)
  end

  def event_response_status_for(event, user)
    event_response_for(event, user).humanized_status
  end
end
