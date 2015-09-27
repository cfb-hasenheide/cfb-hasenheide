class RepliesController < ApplicationController
  def create
    reply = Reply.new(reply_params)

    if reply.save
      flash[:notice] = 'Deine Meldung wurde gespeichert!'
    else
      flash[:error] = 'Deine Meldung konnte nicht gespeichert werden!'
    end

    redirect_to :back
  end

  def index
    @event = Event.find(params[:event_id])
    @replies = Reply.event(params[:event_id])
      .includes(:user_profile).order('user_profiles.alias')
    @reply = Reply.for_event_and_user(@event, current_user)
  end

  # TODO: this is not the yellow of the egg
  def create_multiple
    event_id = params[:event_id]
    user_ids = params[:user_ids]

    redirect_to :back and return unless user_ids

    Reply.yes.where(event_id: event_id).delete_all

    user_ids.each do |user_id|
      Reply.for_event_and_user(event_id, user_id).delete
      Reply.create(event_id: event_id, user_id: user_id, status: 'yes')
    end

    flash[:notice] = "#{user_ids.count} Spieler erfolgreich gemeldet."

    redirect_to :back
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

  def sanitized_params
    # TODO refactor me
    reply_params.reduce({}) do |memo, (k, v)|
      memo[k] = v.to_i
      memo
    end
  end
end
