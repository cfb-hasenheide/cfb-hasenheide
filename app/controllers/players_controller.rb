class PlayersController < ApplicationController
  before_action :set_player, only: %i(edit show update)

  def index
    @players = Player.order(status: :asc, player_pass: :desc, nickname: :asc)
                     .page(params[:page])
  end

  def show; end

  def for_member; end

  def new
    @player = Player.new(member_id: params[:member_id])
  end

  def edit; end

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
                                   :member_id,
                                   :nickname,
                                   :player_pass,
                                   :player_pass_number,
                                   :portrait,
                                   :remove_avatar,
                                   :status)
  end

  def set_player
    @player = Player.friendly.find(params[:id])
  end
end
