module ReportsHelper
  def label_class_for_report(report)
    case report.result
    when 'won' then 'success'
    when 'lost' then 'danger'
    when 'drew' then 'warning'
    else 'default'
    end
  end
end
