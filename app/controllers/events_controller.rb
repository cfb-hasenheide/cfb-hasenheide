class EventsController < ApplicationController
  before_action :set_event, only: [:show,
                                   :edit,
                                   :update,
                                   :destroy,
                                   :open,
                                   :open_with_mail,
                                   :close,
                                   :open_replies_mail]

  respond_to :html

  def index
    @events = Event.order('datetime DESC').page(params[:page])
  end

  def show
    @reply = Reply.find_or_initialize_by(event_id: @event.id,
                                         user_id: current_user.id)
  end

  def new
    @event = Event.new(type: params[:type])

    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save

    respond_with(@event)
  end

  def update
    @event.update(event_params)

    respond_with(@event)
  end

  def destroy
    @event.destroy

    respond_with(@event, location: events_path)
  end

  def open
    if @event.open!
      flash[:notice] = 'Meldeliste wurde erfolgreich geöffnet.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geöffnet werden.'
    end

    redirect_to :back
  end

  def open_with_mail
    if @event.open!
      EventMailer.open_replies(@event.id, message: params[:message]).deliver_later
      flash[:notice] = 'Meldeliste wurde erfolgreich geöffnet.'

      respond_with @event, location: event_path(@event)
    else
      flash[:alert] = 'Meldeliste konnte nicht geöffnet werden.'
      redirect_to :back
    end
  end

  def close
    if @event.close!
      flash[:notice] = 'Meldeliste wurde erfolgreich geschlossen.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geschlossen werden.'
    end

    redirect_to :back
  end

  def open_replies_mail
    @user_aliases =
      User.players_for_event(@event).includes(:user_profile).pluck(:alias).sort
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    event_type = params[:type].underscore.to_sym

    params.require(event_type).permit(:address,
                                      :club_team_id,
                                      :datetime,
                                      :description,
                                      :home,
                                      :maximum,
                                      :minimum,
                                      :name,
                                      :rival_team_id).merge(params.slice(:type))
  end
end
