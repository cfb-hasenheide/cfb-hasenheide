class FunctionsController < ApplicationController
  before_action :set_function, only: %i(destroy update end_up)

  def index
    @functions = Function.all
    @current_functions = Function.current
  end

  def create
    @function = Function.create required_params
    @functions = Function.all
    respond_with(@function, location: functions_url)
  end

  def destroy
    @function.delete
  end

  def update
    @function.update(required_params)
  end

  def end_up
    @function.update(vacated_at: Time.zone.today)
  end

  private

  def set_function
    id = params.require(:id)
    @function = Function.find(id)
  end

  def required_params
    params.require(:function).permit(:user_id,
                                     :role_id,
                                     :assumed_at,
                                     :vacated_at)
  end
end
