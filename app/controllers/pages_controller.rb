class PagesController < PublicController
  def home
    set_events
    set_posts
    @homepage_header = HomepageHeader.active
  end

  def fussball_de
  end

  def contact
  end

  private

  def set_events
    events = Event.all
    events = events.where(public: true) unless user_signed_in?
    @past_events = events.past(3)
    @future_events = events.future(3)
  end

  def set_posts
    posts = Post.all
    posts = posts.where(public: true) unless user_signed_in?
    @posts = posts.order(created_at: :desc).limit(5)
  end
end
