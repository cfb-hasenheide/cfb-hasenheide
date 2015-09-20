module IconsHelper
  def report_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-list-alt')
  end

  def edit_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-wrench')
  end

  def delete_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-trash')
  end

  def date_icon
    content_tag(:span, nil, class: 'fa fa-calendar fa-fw')
  end

  def time_icon
    content_tag(:span, nil, class: 'fa fa-clock-o fa-fw')
  end

  def address_icon
    content_tag(:span, nil, class: 'fa fa-map-marker fa-fw')
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

  def mail_icon
    content_tag(:span, nil, class: 'glyphicon glyphicon-envelope')
  end

  def minus_icon
    content_tag(:span, nil, class: 'fa fa-minus fa-fw')
  end

  def facebook_link_icon
    content_tag(:span, nil, class: 'fa-stack fa-lg') do
      content_tag(:i, nil, class: 'fa fa-circle fa-stack-2x') +
      content_tag(:i, nil, class: 'fa fa-facebook fa-stack-1x fa-inverse')
    end
  end

  def twitter_link_icon
    content_tag(:span, nil, class: 'fa-stack fa-lg') do
      content_tag(:i, nil, class: 'fa fa-circle fa-stack-2x') +
      content_tag(:i, nil, class: 'fa fa-twitter fa-stack-1x fa-inverse')
    end
  end

  def youtube_link_icon
    content_tag(:span, nil, class: 'fa-stack fa-lg') do
      content_tag(:i, nil, class: 'fa fa-circle fa-stack-2x') +
      content_tag(:i, nil, class: 'fa fa-youtube fa-stack-1x fa-inverse')
    end
  end

  def fussballde_link_icon
    content_tag(:span, nil, class: 'fa-stack fa-lg') do
      content_tag(:i, nil, class: 'fa fa-circle fa-stack-2x') +
      content_tag(:i, nil, class: 'fa fa-soccer-ball-o fa-stack-1x fa-inverse')
    end
  end

  def user_icon
    content_tag(:span, nil, class: 'fa fa-user fa-fw')
  end

  def admin_icon
    content_tag(:span, nil, class: 'fa fa-user-plus fa-fw')
  end

  def spinner_icon
    content_tag(:span, nil, class: 'fa fa-spinner fa-pulse')
  end
end
