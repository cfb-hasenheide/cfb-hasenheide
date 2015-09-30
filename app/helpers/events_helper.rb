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

  ### events#index

  def event_label_css_class(event)
    return 'label-default' unless event.report.present? || event.replyable?
    return 'label-success' if event.won?
    return 'label-warning' if event.drawed?
    return 'label-danger' if event.lost?

    'label-primary'
  end

  def event_list_group_item_css_class(event)
    return 'list-group-item disabled' if event.upcoming? && !event.replyable?

    'list-group-item'
  end

  def event_show_path(event)
    if event.upcoming? && event.replyable?
      event_replies_path(event)
    elsif event.past? && event.report.present?
      event_report_path(event)
    else
      event_path(event)
    end
  end
end
