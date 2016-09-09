class TeamPlayersController < ApplicationController
  before_action :authorize_admin!

  def show
    @team = Team.find(params[:team_id])
  end

  def update
    @team = Team.find(params[:team_id])
    @team.update(player_ids: player_ids)
    redirect_to team_players_path(@team)
  end

  private

  def player_ids
    params.require(:player_ids)
  end
end
