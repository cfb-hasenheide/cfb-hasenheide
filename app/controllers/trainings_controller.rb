class TrainingsController < ApplicationController
  before_action :set_players, only: %i(new edit)
  before_action :set_training, only: %i(edit update)

  def index
    @trainings = Training.order(date: :desc).page(params[:page])
  end

  def new
    current_weeks_monday = Time.zone.today.beginning_of_week
    @training = Training.new(date: current_weeks_monday)
  end

  def create
    @training = Training.new(training_params)

    if @training.save
      redirect_to trainings_path, notice: 'Training erstellt.'
    else
      set_players
      render :new, alert: 'Training nicht erstellt!'
    end
  end

  def edit
  end

  def update
    if @training.update(training_params)
      redirect_to trainings_path, notice: 'Training aktualisiert.'
    else
      set_players
      render :edit, alert: 'Training nicht aktualisiert!'
    end
  end

  private

  def set_players
    @players = Player.all.order(:nickname)
  end

  def set_training
    @training = Training.find(params[:id])
  end

  def training_params
    params.require(:training)
          .permit(:date, :additional_count, :additional_info, player_ids: [])
  end
end
