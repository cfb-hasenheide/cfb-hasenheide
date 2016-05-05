module EventsHelper
  def event_attendance_label(event, pull_right: false)
    return unless event.future? && event.attendance_list_open?

    attendance_status = event.attendances.find_by(player_id: current_user.player.id).status

    content_tag(:span,
                t(attendance_status, scope: %w(activerecord enums attendance status)),
                class: "label label-primary #{('pull-right' if pull_right)}")
  end

  def event_final_score_label(event, pull_right: false)
    return unless event.past? && event.report.present?

    css_class = if event.won?
                  'label label-success'
                elsif event.lost?
                  'label label-danger'
                else # event.drew
                  'label label-warning'
                end

    css_class += ' pull-right' if pull_right

    content_tag(:span, event.final_score, class: css_class)
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
