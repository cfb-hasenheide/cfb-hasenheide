class EventsController < ApplicationController
  include ActionController::MimeResponds

  before_action :set_event, only: %i(show edit update destroy)

  before_action :authorize_admin!, except: [:index, :show]

  respond_to :html

  def index
    @events = Event.order('datetime DESC').page(params[:page])
  end

  def show
    @previous_events = Event.previous(@event.id)
    respond_to do |format|
      format.html
      format.ics { render text: @event.to_ics }
    end
  end

  def new
    type = params[:type]
    @event = Event.new(type: type)
    @event.build_attendance_list
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    respond_with(@event, location: events_path)
  end

  private

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :address,
      :club_team_id,
      :rival_team_id,
      :datetime,
      :description,
      :home,
      :name,
      :type,
      :public,
      attendance_list_attributes: [:id, :minimum, :maximum]
    )
  end
end
