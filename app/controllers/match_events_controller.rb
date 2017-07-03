class MatchEventsController < ApplicationController
  def index
    @event = Event.friendly.find(params[:event_id])
    @goals = @event.goals.order(:minute, :extra_time)
  end
end
