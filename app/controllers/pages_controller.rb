class PagesController < PublicController
  before_action :set_events, :set_news, only: :welcome

  def welcome
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

  def set_news
    news = News.all
    news = news.where(internal: false) unless user_signed_in?
    @news = news.order('created_at DESC').limit(5)
  end
end
