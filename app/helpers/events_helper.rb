module EventsHelper
  def event_attendance_label(event, pull_right: false)
    return unless event.future? && event.attendance_list_open?

    attendance_status = event_attendance_status(event)

    return unless attendance_status.present?

    content_tag(:span,
                t(attendance_status, scope: %w(activerecord enums attendance status)),
                class: "label label-primary #{('pull-right' if pull_right)}")
  end

  def event_attendance_status(event)
    event.attendances.find_by(player_id: current_user.player.id)&.status
  end

  def event_final_score_label(event, pull_right: false)
    return unless event.past? && event.report.present?

    css_class = "badge badge-#{event_final_score_indicator_class(event)}"

    css_class += ' pull-right' if pull_right

    content = ''
    content += "#{report_icon} " if event.report.content?
    content += event.final_score

    content_tag(:span, content.html_safe, class: css_class)
  end

  def event_final_score_indicator_class(event)
    return 'success' if event.won?
    return 'danger' if event.lost?
    'warning' # event.drew
  end

  def event_or_attendance_list_or_report_link(event)
    if event.future? && event.attendance_list_open?
      name = event_attendance_label(event) || AttendanceList.model_name.human
      link_to name,
        event_attendance_list_path(event),
        class: 'btn btn-primary'
    elsif event.past? && event.report.present?
      link_to event.final_score,
        event_report_path(event),
        class: "btn btn-outline-#{event_final_score_indicator_class(event)}"
    else
      link_to Event.model_name.human,
        event_path(event),
        class: "btn btn-outline-primary"
    end
  end

  def event_or_attendance_list_or_report(event)
    if event.future? && event.attendance_list_open?
      AttendanceList
    elsif event.past? && event.report.present?
      Report
    else
      Event
    end
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
