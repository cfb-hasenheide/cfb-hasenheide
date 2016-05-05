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
    params.require(:player).permit(:city,
                                   :club_email,
                                   :date_of_birth,
                                   :eligible_to_play_since,
                                   :first_name,
                                   :jersey_name,
                                   :jersey_number,
                                   :last_name,
                                   :member_since,
                                   :member_until,
                                   :membership_number,
                                   :nickname,
                                   :phone1,
                                   :phone2,
                                   :place_of_birth,
                                   :player_pass,
                                   :player_pass_number,
                                   :street,
                                   :user_id,
                                   :zipcode)
  end

  def set_player
    @player = Player.friendly.find(params[:id])
  end
end
