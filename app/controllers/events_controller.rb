class EventsController < ApplicationController
  include ActionController::MimeResponds

  before_action :set_event, only: [:show,
                                   :edit,
                                   :update,
                                   :destroy,
                                   :open,
                                   :close,
                                   :open_with_mail,
                                   :open_replies_mail,
                                   :close_with_mail,
                                   :close_replies_mail]

  before_action :authorize_admin!, except: [:index, :show]

  respond_to :html

  def index
    @events = Event.order('datetime DESC').page(params[:page])
  end

  def show
    @reply = Reply.find_or_initialize_by(event_id: @event.id,
                                         user_id: current_user.id)

    @previous_events = Event.previous(@event.id)

    respond_to do |format|
      format.html
      format.ics { render text: @event.to_ics }
    end
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

    respond_with(@event, location: event_path(@event))
  end

  def update
    @event.update(event_params)

    respond_with(@event, location: event_path(@event))
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

  def open_replies_mail
    @all_users = User.includes(:user_profile).order('user_profiles.alias')

    @possible_users = @event
                      .possible_players
                      .includes(:user_profile)
                      .order('user_profiles.alias')
  end

  def open_with_mail
    if @event.open!
      EventMailer
        .open_replies(@event.id,
                      to_user_ids: params[:user_ids],
                      message: params[:message],
                      from_user_id: current_user.id)
        .deliver_later

      flash[:notice] =
        'Meldeliste wurde erfolgreich geöffnet und Mail versendet.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geöffnet werden.'
    end

    redirect_to event_path(@event)
  end

  def close
    if @event.close!
      flash[:notice] = 'Meldeliste wurde erfolgreich geschlossen.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geschlossen werden.'
    end

    redirect_to :back
  end

  def close_replies_mail
    @all_users = User.includes(:user_profile).order('user_profiles.alias')

    @attending_players = @event.attending_players
  end

  def close_with_mail
    if @event.close!
      EventMailer
        .close_replies(@event.id, message: params[:message])
        .deliver_later

      flash[:notice] =
        'Meldeliste wurde erfolgreich geschlossen und Final Call versendet.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geschlossen werden.'
    end

    redirect_to :back
  end

  private

  def set_event
    @event = Event.friendly.find(params[:id])
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
