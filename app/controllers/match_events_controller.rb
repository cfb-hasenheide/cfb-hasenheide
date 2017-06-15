class MatchEventsController < ApplicationController
  def index
    @event = Event.friendly.find(params[:event_id])
    @goals = Goal.all.order(:minute, :extra_time)
  end
end
