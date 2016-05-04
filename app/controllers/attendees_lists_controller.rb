class AttendeesListsController < ApplicationController
  def show
    @event = Event.friendly.find(params[:event_id])
    @attendees_list = @event.attendees_list

    if @attendees_list.nil?
      redirect_to :back, alert: 'Meldeliste nicht vorhanden!' and return
    end
  end
end
