class FunctionsController < ApplicationController
  def index
    @functions = Function.all
    @current_functions = Function.current
  end

  def create
    @function= Function.create required_params
    @functions = Function.all
    respond_with(@function, location: functions_url)
  end

  def destroy
    # TODO need a assignment controller to split
    # destroying function and vacated it out
    id = params.require(:id)
    function = Function.find(id)
    function.update(vacated_at: DateTime.now)
  end

  private

  def required_params
    params.require(:function).permit(:user_id,
                                     :role_id,
                                     :assumed_at,
                                     :vacated_at)
  end
end
