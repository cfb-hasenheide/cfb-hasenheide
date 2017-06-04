class MediaController < ApplicationController
  before_action :set_medium, only: %i[show destroy]

  def index
    @media = Medium.all
  end

  def show; end

  def new
    @medium = Medium.new
  end

  def create
    @medium = Medium.new(medium_params)

    if @medium.save
      redirect_to media_path, notice: t('.notice')
    else
      render :new
    end
  end

  def destroy
    @medium.destroy!
    redirect_to media_path, notice: t('.notice')
  end

  private

  def medium_params
    params.require(:medium)
          .permit(:description, :file, :file_cache, :user_id, :type)
  end

  def set_medium
    @medium = Medium.find(params[:id])
  end
end
