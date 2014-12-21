class UsersController < ApplicationController
  # before_action :admin_check, only: [:index]
  before_action :set_user, only: [:update]

  respond_to :html

  def index
    @users = User.all.order('username')

    respond_with(@users)
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User wurde erfolgreich aktualisiert.'
    end

    respond_with(@user, location: users_url)
  end

  private

  def admin_check
    redirect_to :root and return unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :role)
  end
end
