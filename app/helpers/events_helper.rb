module EventsHelper
  def event_kind_options
    Event.kinds.reduce({}) do |memo, (k, _)|
      memo[Event::KINDS[k.to_sym]] = k
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

  def class_for(status)
    case status
    when :yes then'success'
    when :maybee then 'warning'
    when :no then 'danger'
    when :watch then 'info'
    else 'default'
    end
  end
end
