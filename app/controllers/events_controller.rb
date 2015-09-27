class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :open, :close]

  respond_to :html

  def index
    @events = Event.order('datetime DESC').page(params[:page])
  end

  def show
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

  def open
    if @event.open!
      flash[:notice] = 'Meldeliste wurde erfolgreich geöffnet.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geöffnet werden.'
    end

    respond_with(@event, location: event_replies_path(@event))
  end

  def close
    if @event.close!
      flash[:notice] = 'Meldeliste wurde erfolgreich geschlossen.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geschlossen werden.'
    end

    respond_with(@event, location: event_replies_path(@event))
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
