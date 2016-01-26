module EventsHelper
  def event_progress_bar_css_class(event)
    if event.yes_and_waiting_count < event.minimum
      'progress-bar-danger'
    elsif event.yes_and_waiting_count >= event.minimum &&
      event.yes_and_waiting_count < event.minimum + 3
      'progress-bar-warning'
    else
      'progress-bar-success'
    end
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
    return 'list-group-item disabled' if event.future? && !event.replyable?

    'list-group-item'
  end

  def event_show_path(event)
    if event.future? && event.replyable?
      event_replies_path(event)
    elsif event.past? && event.report.present?
      event_report_path(event)
    else
      event_path(event)
    end
  end
end
