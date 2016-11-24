class HomepageHeadersController < ApplicationController
  before_action :set_homepage_header, only: %i(edit update destroy activate)

  def index
    authorize!(:read, HomepageHeader)
    @homepage_headers = HomepageHeader.all
  end

  def new
    authorize!(:create, HomepageHeader)
    @homepage_header = HomepageHeader.new
  end

  def edit
    authorize!(:update, HomepageHeader)
  end

  def create
    authorize!(:create, HomepageHeader)
    @homepage_header = HomepageHeader.new(homepage_header_params)

    if @homepage_header.save
      redirect_to homepage_headers_url,
                  notice: 'Homepage Header wurde erstellt.'
    else
      render :new
    end
  end

  def update
    authorize!(:update, HomepageHeader)
    if @homepage_header.update(homepage_header_params)
      redirect_to homepage_headers_url,
                  notice: 'Homepage Header wurde aktualisiert.'
    else
      render :edit
    end
  end

  def destroy
    authorize!(:destroy, HomepageHeader)
    @homepage_header.destroy

    redirect_to homepage_headers_url, notice: 'Homepage Header wurde gelöscht.'
  end

  def activate
    authorize!(:update, HomepageHeader)
    if @homepage_header.activate
      flash.notice = 'Homepage Header wurde aktiviert.'
    else
      flash.alert = 'Homepage Header wurde nicht aktiviert: ' \
                    "#{@homepage_header.errors.full_messages.to_sentence}"
    end

    redirect_to homepage_headers_path
  end

  private

  def homepage_header_params
    params.require(:homepage_header).permit(:background_image,
                                            :background_image_cache,
                                            :background_position_y,
                                            :color,
                                            :heading,
                                            :remove_background_image,
                                            :text)
  end

  def set_homepage_header
    @homepage_header = HomepageHeader.find(params[:id])
  end
end
