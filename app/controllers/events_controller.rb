class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @events = Event.order('datetime DESC').page(params[:page])
  end

  def show
    redirect_to event_report_path(@event) and return if @event.report.present?
    redirect_to event_replies_path(@event) and return if @event.replyable?

    respond_with(@event)
  end

  def new
    @event = Event.new

    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save

    respond_with(@event, location: events_path)
  end

  def update
    @event.update(event_params)

    respond_with(@event)
  end

  def destroy
    @event.destroy

    respond_with(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:kind, :name, :datetime,
                                  :club_team_id, :rival_team_id, :description,
                                  :address, :minimum, :maximum, :home)
  end
end
