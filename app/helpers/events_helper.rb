module EventsHelper
  def event_kind_options
    Event.kinds.reduce({}) do |memo, (enum, _)|
      memo[I18n.t("event_kind.#{enum}")] = enum
      memo
    end
  end

  def yes_quota_for(event)
    yeses = event.yes_count.to_f
    maximum = progress_bar_maximum_for(event).to_f

    return 0 if (yeses.zero? || maximum.zero?)
    yeses / maximum
  end

  def waiting_quota_for(event)
    waitees = event.waiting_count.to_f
    maximum = progress_bar_maximum_for(event).to_f

    return 0 if (waitees.zero? || maximum.zero?)
    waitees / maximum
  end

  def progress_bar_maximum_for(event)
    [event.maximum, event.yes_count + event.waiting_count].max
  end

  def minimum_reached?(event)
    event.yes_count + event.waiting_count >= event.minimum
  end

  def css_class_for_event(event)
    return 'default' unless event.past?
    # return 'primary' if event.repliable?
    return 'success' if event.won?
    return 'warning' if event.drawed?
    return 'danger' if event.lost?
    'danger'
  end

  def class_for(status)
    case status
    when :yes then'success'
    when :waiting then'success'
    when :maybee then 'warning'
    when :no then 'danger'
    when :watch then 'info'
    else 'default'
    end
  end
end
