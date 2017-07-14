class GoalsController < ApplicationController
  before_action :set_players, only: %i[new create]

  def new
    @event = Event.friendly.find(params[:event_id])
    @goal = @event.goals.new
  end

  def create
    @event = Event.find(goal_params[:event_id])
    @goal = Goal.new(goal_params)

    if @goal.save
      redirect_to event_match_events_path(@event)
    else
      render :new
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:event_id,
                                 :extra_time,
                                 :minute,
                                 :club_score,
                                 :rival_score,
                                 :club,
                                 :scorer_id,
                                 :provider_id,
                                 :comment,
                                 :reporter_id)
  end

  def set_players
    @players = Player.all.order(:nickname)
  end
end
