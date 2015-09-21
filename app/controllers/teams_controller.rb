class TeamsController < ApplicationController
  before_action :set_team, only: [:edit, :update]
  before_action :authorize_admin!

  respond_to :html

  def index
    @teams = Team.order('club DESC, current_season DESC, name').page(params[:page])
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    @team.save

    respond_with(@team, location: teams_path)
  end

  def update
    @team.update(team_params)

    respond_with(@team, location: teams_url)
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description, :club)
  end
end
