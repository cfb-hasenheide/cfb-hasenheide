class RepliesController < ApplicationController
  before_action :authorize_admin!, only: :update_multiple

  def create
    reply = Reply.new(reply_params)

    if reply.save
      flash[:notice] = 'Deine Meldung wurde gespeichert.'
    else
      flash[:alert] = 'Deine Meldung konnte nicht gespeichert werden!'
    end

    redirect_to :back
  end

  def index
    @event = Event.find(params[:event_id])
    @previous_events = Event.previous(params[:event_id])

    @replies = Reply.event(params[:event_id])
      .includes(:user_profile).order('user_profiles.alias')
    @reply = Reply.for_event_and_user(@event, current_user)
  end

  def update_multiple
    if Reply.update(replies_params.keys, replies_params.values)
      flash[:notice] = 'Deine Meldungen wurden gespeichert.'
    else
      flash[:alert] = 'Deine Meldungen konnten nicht gespeichert werden!'
    end

    event_id = Reply.find(replies_params.keys.first).event_id
    respond_with event_id, location: event_replies_path(event_id)
  end

  def update
    reply = Reply.find(params[:id])

    if reply.update(reply_params)
      flash[:notice] = 'Deine Meldung wurde aktualisiert!'
    else
      flash[:error] = 'Deine Meldung konnte nicht aktualisiert werden!'
    end

    redirect_to :back
  end

  private

  def reply_params
    params.require(:reply).permit(:event_id, :user_id, :status)
  end

  def replies_params
    params.require(:replies).permit!
  end

  def sanitized_params
    # TODO refactor me
    reply_params.reduce({}) do |memo, (k, v)|
      memo[k] = v.to_i
      memo
    end
  end
end
