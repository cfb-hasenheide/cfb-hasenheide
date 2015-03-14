class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update]

  respond_to :html

  def index
    @user_profiles = UserProfile.all
    respond_with(@user_profiles)
  end

  def show
    respond_with(@user_profile)
  end

  def edit
  end

  def update
    @user_profile.update(user_profile_params)
    respond_with(@user_profile)
  end

  private
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    def user_profile_params
      params.require(:user_profile).permit(:user_id, :alias, :avatar)
    end
end
