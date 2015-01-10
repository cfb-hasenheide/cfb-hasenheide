module IconHelper
  def report_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-list-alt')
  end

  def edit_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-wrench')
  end

  def delete_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-trash')
  end

  def datetime_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-calendar')
  end

  def address_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-map-marker')
  end

  def create_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-plus')
  end

  def link_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-link')
  end

  def save_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-ok')
  end
end
