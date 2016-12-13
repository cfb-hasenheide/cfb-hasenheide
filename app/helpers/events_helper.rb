module EventsHelper
  def event_attendance_label(event, pull_right: false)
    return unless event.future? && event.attendance_list_open?

    attendance_status =
      event.attendances.find_by(player_id: current_user.player.id).try(:status)

    return unless attendance_status.present?

    content_tag(:span,
                t(attendance_status, scope: %w(activerecord enums attendance status)),
                class: "tag tag-primary #{('pull-right' if pull_right)}")
  end

  def event_final_score_label(event, pull_right: false)
    return unless event.past? && event.report.present?

    css_class = if event.won?
                  'tag tag-success'
                elsif event.lost?
                  'tag tag-danger'
                else # event.drew
                  'tag tag-warning'
                end

    css_class += ' pull-right' if pull_right

    content = ''
    content += "#{report_icon} " if event.report.content?
    content += event.final_score

    content_tag(:span, content.html_safe, class: css_class)
  end

  def event_or_attendance_list_or_report_link(event)
    if event.future? && event.attendance_list_open?
      text = AttendanceList.model_name.human
      path = event_attendance_list_path(event)
    elsif event.past? && event.report.present?
      text = Report.model_name.human
      path = event_report_path(event)
    else
      text = Event.model_name.human
      path = event_path(event)
    end

    link_to text, path, class: 'btn btn-outline-primary'
  end
end
