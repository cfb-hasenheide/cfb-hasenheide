class EventResponsesController < ApplicationController
  def create
    event_response = EventResponse.new(event_response_params)

    if event_response.save
      flash[:notice] = 'Deine Meldung wurde gespeichert!'
    else
      flash[:error] = 'Deine Meldung konnte nicht gespeichert werden!'
    end

    redirect_to :back
  end

  def update
    event_response = EventResponse
      .find_by(event_response_params.slice(:event_id, :user_id))

    if event_response.update(event_response_params)
      flash[:notice] = 'Deine Meldung wurde aktualisiert!'
    else
      flash[:error] = 'Deine Meldung konnte nicht aktualisiert werden!'
    end

    redirect_to :back
  end

  private

  def event_response_params
    params.require(:event_response).permit(:event_id, :user_id, :status)
  end

  def sanitized_params
    # TODO refactor me
    event_response_params.reduce({}) do |memo, (k, v)|
      memo[k] = v.to_i
      memo
    end
  end
end
