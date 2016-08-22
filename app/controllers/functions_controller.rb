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
    id = params.require(:id)
    function = Function.find(id)
    function.delete
  end

  def update
    id = params.require(:id)
    function = Function.find(id)
    function.update(required_params)
  end

  def end_up
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
