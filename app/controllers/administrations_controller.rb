class AdministrationsController < ApplicationController
  def show
    authorize!(:create, Function) &&
      authorize!(:update, Team) &&
      authorize!(:update, User)
  end
end
