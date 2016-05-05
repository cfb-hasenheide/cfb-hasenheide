class ReportsController < ApplicationController
  before_action :set_report, only: [:edit, :update]

  respond_to :html

  def index
    @reports = Report.includes(:event)
                     .order('events.datetime DESC')
                     .page(params[:page])
  end

  def no_content
    @reports = Report.no_content
                     .includes(:event)
                     .order('events.datetime DESC')
                     .page(params[:page])
  end

  def missing
    @events_without_report = Event.past.without_report.page(params[:page])
  end

  def show
    @event = Event.friendly.find(params[:event_id])
    @report = @event.report

    if @report.nil? && current_user.admin?
      redirect_to new_report_path(event_id: @event.id)
    elsif @report.nil?
      redirect_to :back, alert: 'Spielbericht nicht vorhanden!' and return
    end
  end

  def new
    @report = Report.new(event_id: params[:event_id])
  end

  def create
    @report = Report.new(report_params)
    flash[:notice] = 'Bericht wurde erfolgreich erstellt.' if @report.save

    respond_with @report, location: reports_path
  end

  def edit
  end

  def update
    if @report.update(report_params)
      flash[:notice] = 'Bericht wurde erfolgreich aktualisiert.'
    end

    respond_with @report
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:annotation,
                                   :captain_id,
                                   :club_final_score,
                                   :club_half_time_score,
                                   :content,
                                   :corners_club,
                                   :corners_rival,
                                   :goalkeeper_id,
                                   :incident,
                                   :most_valuable_player_id,
                                   :possession,
                                   :referee,
                                   :referee_description,
                                   :referee_name,
                                   :reporter_id,
                                   :rival_final_score,
                                   :rival_half_time_score,
                                   :turf,
                                   :weather)
  end
end
