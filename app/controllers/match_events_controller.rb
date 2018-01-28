class MatchEventsController < ApplicationController
  def index
    @event = Event.friendly.find(params[:event_id])
    @goals = @event.goals
                   .includes(:provider, :reporter, :scorer)
                   .order(minute: :desc, extra_time: :desc)
  end
end
