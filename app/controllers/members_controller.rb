class MembersController < ApplicationController
  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = 'Erfogreich geupdated'
      redirect_to player_path @member.player
    else
      render 'edit'
    end
  end

  private

  def member_params
    params.require(:member).permit(:firstname,
                                   :identifier,
                                   :lastname,
                                   :date_of_birth,
                                   :place_of_birth,
                                   :member_since,
                                   :member_until,
                                   :user_id)
  end
end
