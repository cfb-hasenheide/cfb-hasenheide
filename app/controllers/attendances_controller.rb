class AttendancesController < ApplicationController
  before_action :authorize_admin!,
                :set_attendance_list,
                only: %i(edit_multiple update_multiple)

  def update
    @attendance = Attendance.find(params[:id])

    if @attendance.update(attendance_params)
      flash[:notice] = 'Deine Meldung wurde aktualisiert!'
    else
      flash[:error] = 'Deine Meldung konnte nicht aktualisiert werden!'
    end

    redirect_to event_attendance_list_path(@attendance.attendance_list.attendable_id)
  end

  def edit_multiple
    @attendances = @attendance_list.attendances
                                   .includes(:player)
                                   .order('players.nickname')
  end

  def update_multiple
    if Attendance.update(attendances_params.keys, attendances_params.values)
      flash[:notice] = 'Deine Meldungen wurden gespeichert.'
    else
      flash[:alert] = 'Deine Meldungen konnten nicht gespeichert werden!'
    end

    redirect_to event_attendance_list_path(@attendance_list.attendable_id)
  end

  private

  def attendance_params
    params.require(:attendance).permit(:status)
  end

  def attendances_params
    params.require(:attendances).permit!
  end

  def set_attendance_list
    @attendance_list = AttendanceList.find(params[:attendance_list_id])
  end
end
