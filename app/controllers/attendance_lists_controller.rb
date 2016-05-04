class AttendanceListsController < ApplicationController
  before_action :set_attendance_list, only: %i(open close)

  def show
    @event = Event.friendly.find(params[:event_id])
    @attendance_list = @event.attendance_list

    if @attendance_list.nil?
      redirect_to :back, alert: 'Meldeliste nicht vorhanden!' and return
    end
  end

  def open
    if @attendance_list.open!
      flash[:notice] = 'Meldeliste wurde erfolgreich geöffnet.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geöffnet werden.'
    end
    redirect_to :back
  end

  # def open_replies_mail
  #   @all_players = Player.includes(:user).order(:nickname)
  #   @possible_users = Player.active
  #                           .player_pass(@event.player_pass_needed?)
  #                           .order(:nickname)
  # end
  #
  # def open_with_mail
  #   if @attendance_list.open!
  #     EventMailer
  #       .open_replies(@event.id,
  #                     to_user_ids: params[:user_ids],
  #                     message: params[:message],
  #                     from_user_id: current_user.id)
  #       .deliver_later
  #     flash[:notice] =
  #       'Meldeliste wurde erfolgreich geöffnet und Mail versendet.'
  #   else
  #     flash[:alert] = 'Meldeliste konnte nicht geöffnet werden.'
  #   end
  #   redirect_to event_path(@event)
  # end

  def close
    if @attendance_list.close!
      flash[:notice] = 'Meldeliste wurde erfolgreich geschlossen.'
    else
      flash[:alert] = 'Meldeliste konnte nicht geschlossen werden.'
    end
    redirect_to :back
  end

  # def close_replies_mail
  #   @all_players = Player.includes(:user).order(:nickname)
  #   @attending_players = @event.attending_players
  # end
  #
  # def close_with_mail
  #   if @attendance_list.close!
  #     EventMailer
  #       .close_replies(@event.id, message: params[:message])
  #       .deliver_later
  #     flash[:notice] =
  #       'Meldeliste wurde erfolgreich geschlossen und Final Call versendet.'
  #   else
  #     flash[:alert] = 'Meldeliste konnte nicht geschlossen werden.'
  #   end
  #   redirect_to :back
  # end

  private

  def set_attendance_list
    @attendance_list = AttendanceList.find(params[:id])
  end
end
