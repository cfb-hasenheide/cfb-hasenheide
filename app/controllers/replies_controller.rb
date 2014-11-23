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

  def update
    reply = Reply.find_by(reply_params.slice(:event_id, :user_id))

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
