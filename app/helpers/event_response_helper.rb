module EventResponseHelper
  def status_options
    # TODO use i18n translation
    { 'M - Meldung' => 'yes',
      '0 - Absage' => 'no',
      '? - Vielleicht' => 'maybee',
      'Z - Zuschauer' => 'watch' }
  end
end
