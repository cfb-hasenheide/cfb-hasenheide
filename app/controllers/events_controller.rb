class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @events = Event.order('datetime DESC').page(params[:page])
  end

  def show
    @players = User.players
    @yes_replies = Reply.by_event_and_status(@event, :yes)
    @no_replies = Reply.by_event_and_status(@event, :no)
    @waiting_replies = Reply.by_event_and_status(@event, :waiting)
    @maybee_replies = Reply.by_event_and_status(@event, :maybee)
    @watch_replies = Reply.by_event_and_status(@event, :watch)
    @no_reply_players = User.didnt_reply_to_event(@event.id)
    @reply = Reply.for_event_and_user(@event, current_user)

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
    flash[:notice] = 'Event wurde erfolgreich erstellt.' if @event.save

    respond_with(@event, location: events_path)
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event wurde erfolgreich aktualisiert.'
    end

    respond_with(@event)
  end

  def destroy
    @event.destroy
    flash[:notice] = 'Event wurde erfolgreich gelöscht.'

    respond_with(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:kind, :name, :datetime, :home_team,
                                  :away_team, :description, :address,
                                  :minimum, :maximum)
  end
end
