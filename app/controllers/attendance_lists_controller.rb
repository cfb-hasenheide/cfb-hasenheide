class AttendanceListsController < ApplicationController
  before_action :set_event, only: %i(new show)
  before_action :set_attendance_list, only: %i(close close_mail open open_mail)

  def show
    @attendance_list = @event.attendance_list

    if @attendance_list.nil?
      redirect_to event_path(@event), alert: 'Meldeliste nicht vorhanden!'
      return
    end

    @current_user_attendance =
      @attendance_list.attendances.find_by(player_id: current_user.player.id)
  end

  def new
    authorize!(:create, AttendanceList)
    @attendance_list = @event.build_attendance_list
  end

  def create
    authorize!(:create, AttendanceList)

    @event = Event.friendly.find(attendance_list_params[:attendable_id])
    @attendance_list = AttendanceList.new(attendance_list_params)

    if @attendance_list.save
      redirect_to event_attendance_list_path(@event),
                  notice: 'Meldeliste erfolgreich erstellt.'
    else
      render :new, alert: 'Meldeliste nicht erstellt!'
    end
  end

  def close
    authorize! :close, @attendance_list
    if @attendance_list.close!
      flash[:notice] = 'Meldeliste wurde erfolgreich geschlossen.'
      deliver_attendance_list_closed_mail if params[:mail]
    else
      flash[:alert] = 'Meldeliste konnte nicht geschlossen werden.'
    end

    redirect_to event_attendance_list_path(@attendance_list.attendable_id)
  end

  def close_mail
    authorize! :close, @attendance_list
    @first_choice = @attendance_list.attendable.attending_players
    @receiver_ids = @first_choice.pluck(:id)
  end

  def open_mail
    authorize! :open, @attendance_list
    @first_choice = @attendance_list.club_team.players
    @receiver_ids = @attendance_list.attendable.eligible_players.pluck(:id)
  end

  def open
    authorize! :open, @attendance_list
    if @attendance_list.open!
      flash[:notice] = 'Meldeliste wurde erfolgreich geöffnet.'
      deliver_attendance_list_opened_mail if params[:mail]
    else
      flash[:alert] = 'Meldeliste konnte nicht geöffnet werden.'
    end

    redirect_to event_attendance_list_path(@attendance_list.attendable_id)
  end

  private

  def attendance_list_params
    params.require(:attendance_list)
          .permit(:maximum, :minimum, :attendable_id, :attendable_type)
  end

  def deliver_attendance_list_closed_mail
    EventMailer.attendance_list_closed(@attendance_list.attendable_id,
                                       to_player_ids: params[:player_ids],
                                       message: params[:message],
                                       time_to_meet: params[:time_to_meet].to_i,
                                       from_user_id: current_user.id)
               .deliver_later

    flash[:notice] += ' Final Call wurde versendet.'
  end

  def deliver_attendance_list_opened_mail
    EventMailer.attendance_list_opened(@attendance_list.attendable_id,
                                       to_player_ids: params[:player_ids],
                                       message: params[:message],
                                       from_user_id: current_user.id)
               .deliver_later

    flash[:notice] += ' Mail wurde versendet.'
  end

  def set_attendance_list
    @attendance_list = AttendanceList.find(params[:id])
  end

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end
end
