module IconsHelper
  def cancel_icon
    fa_icon('ban')
  end

  def chart_icon
    fa_icon('bar-chart')
  end

  def check_icon
    fa_icon('check')
  end

  def edit_icon
    fa_icon(:pencil)
  end

  def delete_icon
    fa_icon(:trash)
  end

  def date_icon
    fa_icon(:calendar)
  end

  def time_icon
    fa_icon('clock-o')
  end

  def address_icon
    fa_icon('map-marker')
  end

  def create_icon
    fa_icon(:plus)
  end

  def link_icon
    fa_icon(:link)
  end

  def mail_icon
    fa_icon(:envelope)
  end

  def mail_to_link_icon
    content_tag_container('fa fa-envelope fa-stack-1x fa-inverse')
  end

  def facebook_link_icon
    content_tag_container('fa fa-facebook fa-stack-1x fa-inverse')
  end

  def twitter_link_icon
    content_tag_container('fa fa-twitter fa-stack-1x fa-inverse')
  end

  def youtube_link_icon
    content_tag_container('fa fa-youtube fa-stack-1x fa-inverse')
  end

  def goal_icon
    fa_icon('soccer-ball-o')
  end

  alias_method :fussball_de_icon, :goal_icon

  def fussballde_link_icon
    content_tag_container('fa fa-soccer-ball-o fa-stack-1x fa-inverse')
  end

  def content_tag_container(css_class)
    content_tag(:span, nil, class: 'fa-stack fa-lg') do
      content_tag(:i, nil, class: 'fa fa-circle fa-stack-2x') +
        content_tag(:i, nil, class: css_class)
    end
  end

  def user_icon
    fa_icon(:user)
  end

  def spinner_icon
    fa_icon('spinner pulse')
  end

  def login_icon
    fa_icon('sign-in')
  end

  def logout_icon
    fa_icon('sign-out')
  end

  def download_icon
    fa_icon(:download)
  end

  def report_icon
    fa_icon('file-text')
  end

  def chat_icon
    fa_icon('comments-o')
  end

  def chat_message_icon
    fa_icon('commenting-o')
  end

  def list_icon
    fa_icon(:list)
  end

  def comment_icon
    fa_icon(:comment)
  end

  def internal_icon
    fa_icon('eye-slash')
  end

  def public_icon
    fa_icon('eye')
  end

  def refresh_icon
    fa_icon('refresh')
  end

  def refreshing_icon
    fa_icon('refresh spin')
  end

  def full_screen_icon
    fa_icon('window-maximize')
  end

  def close_icon
    fa_icon('close')
  end
end
