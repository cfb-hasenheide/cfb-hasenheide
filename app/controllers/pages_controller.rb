class PagesController < PublicController
  def welcome
    @news = News.order('created_at DESC').limit(3)
    @past_events = Event.past(3)
    @upcoming_events = Event.upcoming(3)
  end

  def contact
  end
end
