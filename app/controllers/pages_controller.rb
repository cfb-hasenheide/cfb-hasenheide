class PagesController < PublicController
  def welcome
    @news = News.all
    @news = @news.where(internal: false) unless user_signed_in?
    @news = @news.order('created_at DESC').limit(5)
    @past_events = Event.past(3)
    @future_events = Event.future(3)
  end

  def fussball_de
  end

  def contact
  end
end
