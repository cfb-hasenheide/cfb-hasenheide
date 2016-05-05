module EventsHelper
  def event_label_css_class(event)
    return 'label-default' unless event.report.present? || event.attendance_list_open?
    return 'label-success' if event.won?
    return 'label-warning' if event.drawed?
    return 'label-danger' if event.lost?

    'label-primary'
  end

  def event_or_attendance_list_or_report_path(event)
    if event.future? && event.attendance_list_open?
      event_attendance_list_path(event)
    elsif event.past? && event.report.present?
      event_report_path(event)
    else
      event_path(event)
    end
  end
end
