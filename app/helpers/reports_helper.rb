module ReportsHelper
  def contextual_class_for_report(report)
    case report.result
    when 'won' then 'success'
    when 'lost' then 'danger'
    when 'drew' then 'warning'
    else 'default'
    end
  end

  def corners(report)
    return unless report.corners_rival? || report.corners_club?
    corners = [report.corners_rival, report.corners_club]
    corners = corners.reverse if report.home?
    corners.join(' : ')
  end

  def incident_options
    Report.incidents.each_with_object({}) do |(enum, _), options|
      translated_enum =
        I18n.t(enum, scope: %w(activerecord enums report incident))
      options[translated_enum] = enum
    end
  end

  def turf_options
    Report.turves.each_with_object({}) do |(enum, _), options|
      translated_enum = I18n.t(enum, scope: %w(activerecord enums report turf))
      options[translated_enum] = enum
    end
  end

  def weather_options
    Report.weathers.each_with_object({}) do |(enum, _), options|
      translated_enum =
        I18n.t(enum, scope: %w(activerecord enums report weather))
      options[translated_enum] = enum
    end
  end
end
