module AttendancesHelper
  def status_options
    Attendance.statuses.each_with_object({}) do |(enum, _), options|
      translated_enum =
        I18n.t(enum, scope: %w(activerecord enums attendance status))
      options[translated_enum] = enum
    end
  end
end
