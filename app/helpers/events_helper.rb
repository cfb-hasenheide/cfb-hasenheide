module EventsHelper
  def event_label_css_class(event)
    return 'label-default' unless event.report.present? || event.attendance_list_open?
    return 'label-success' if event.won?
    return 'label-warning' if event.drawed?
    return 'label-danger' if event.lost?

    'label-primary'
  end

  def event_list_group_item_css_class(event)
    return 'list-group-item disabled' if event.future? && !event.attendance_list_open?

    'list-group-item'
  end
end
