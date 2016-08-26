class PlayersController < ApplicationController
  before_action :set_player, only: %i(edit show update)

  def index
    @players = Player.order(status: :asc, player_pass: :desc, nickname: :asc)
                     .page(params[:page])
  end

  def show
  end

  def for_user
  end

  def new
    @player = Player.new(user_id: params[:user_id])
  end

  def edit
  end

  def create
    @player = Player.create(player_params)

    respond_with @player
  end

  def update
    @player.update(player_params)

    respond_with @player
  end

  private

  def player_params
    params.require(:player).permit(:avatar,
                                   :avatar_cache,
                                   :eligible_to_play_since,
                                   :jersey_name,
                                   :jersey_number,
                                   :nickname,
                                   :player_pass,
                                   :player_pass_number,
                                   :remove_avatar,
                                   :status,
                                   :user_id)
  end

  def address_params
    params.require(:player).require(:address).permit(:street, :zipcode, :city)
  end

  def contact_params
    params.require(:player).require(:contact).permit(:lastname,
                                                     :firstname,
                                                     :phone1,
                                                     :phone2,
                                                     :date_of_birth,
                                                     :club_email,
                                                     :place_of_birth)
  end

  def member_params
    params.require(:player).require(:member).permit(:member_since,
                                                    :member_until,
                                                    :membership_number)
  end

  def set_player
    @player = Player.friendly.find(params[:id])
  end
end
