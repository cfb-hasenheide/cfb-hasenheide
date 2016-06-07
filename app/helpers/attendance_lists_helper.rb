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

  def time_to_meet
    [
      ['30 min vorher', 30],
      ['45 min vorher', 45],
      ['60 min vorher', 60]
    ]
  end
end
