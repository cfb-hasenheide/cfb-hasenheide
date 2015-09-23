class ReportsController < ApplicationController
  before_action :set_report, only: [:edit, :update]

  respond_to :html

  def index
    @reports = Report.all.page(params[:page])
  end

  def new
    @report = Report.new(params['event_id'])
  end

  def create
    flash[:notice] = 'Bericht wurde erfolgreich erstellt.' if @report.save

    respond_with(@report)
  end

  def edit
  end

  def update
    if @report.update(report_params)
      flash[:notice] = 'Bericht wurde erfolgreich aktualisiert.'
    end

    respond_with(@report)
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:event_id, :content)
  end
end
