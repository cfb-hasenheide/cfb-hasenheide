class TeamsController < ApplicationController
  before_action :admin_check
  before_action :set_team, only: :update

  respond_to :html

  def index
    @teams = Team.all.order('name')

    respond_with(@teams)
  end

  def update
    if @team.update(team_attributes)
      flash[:notice] = 'Team wurde erfolgreich aktualisiert'
    end

    respond_with(@team, location: teams_url)
  end

  private

  def admin_check
    redirect_to :root and return unless current_user.admin?
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def user_params
    params.require(:team).permit(:name)
  end
end
