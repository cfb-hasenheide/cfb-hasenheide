class PagesController < PublicController
  def welcome
    @news = News.order('created_at DESC').limit(3)
    @past_events = Event.past(3)
    @future_events = Event.future(3)
  end

  def contact
  end
end
