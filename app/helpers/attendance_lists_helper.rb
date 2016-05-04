module AttendanceListsHelper
  def attendance_list_progress_bar_css_class(attendance_list)
    if attendance_list.yes_and_waiting_count < attendance_list.minimum
      'progress-bar-danger'
    elsif attendance_list.yes_and_waiting_count >= attendance_list.minimum &&
          attendance_list.yes_and_waiting_count < attendance_list.minimum + 3
      'progress-bar-warning'
    else
      'progress-bar-success'
    end
  end
end
