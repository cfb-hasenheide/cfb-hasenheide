class FunctionsController < ApplicationController
  before_action :set_function, only: %i(destroy update)

  def index
    @functions = Function.all
    @function = Function.new
    @current_functions = Function.current
  end

  def create
    @function = Function.create required_params
    @functions = Function.all
    respond_with(@function, location: functions_url)
  end

  def new
    @function = Function.new
    respond_with(@function)
  end

  def destroy
    @function.delete
  end

  def update
    @function.update(required_params)
  end

  private

  def set_function
    id = params.require(:id)
    @function = Function.find(id)
  end

  def required_params
    params.require(:function).permit(:user_id,
                                     :role_id,
                                     :assumed_on,
                                     :vacated_on)
  end
end
