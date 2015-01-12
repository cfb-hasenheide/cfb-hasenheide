module EventsHelper
  def event_kind_options
    Event.kinds.reduce({}) do |memo, (k, _)|
      memo[Event::KINDS[k.to_sym]] = k
      memo
    end
  end

  def yes_quota_for(event)
    yeses = event.yes_count.to_f
    maximum = event.maximum.to_f

    return 0 if (yeses.zero? || maximum.zero?)

    yeses / maximum
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
