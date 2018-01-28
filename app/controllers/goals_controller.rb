class GoalsController < ApplicationController
  before_action :set_players, only: %i[new edit create]

  def new
    @event = Event.friendly.find(params[:event_id])
    @goal = @event.goals.new
  end

  def edit
    @goal = Goal.find(params[:id])
    @event = @goal.event
  end

  def create
    @event = Event.find(goal_params[:event_id])
    @goal = Goal.new(goal_params)

    if @goal.save
      redirect_to event_match_events_path(@event),
        notice: t('.success', model_name: Goal.model_name.human)
    else
      render :new
    end
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to event_match_events_path(@goal.event)
    else
      set_players
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy

    redirect_to event_match_events_path(@goal.event),
      notice: t('.success', model_name: Goal.model_name.human)
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
