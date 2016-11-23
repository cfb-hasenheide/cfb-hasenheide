class HomepageHeadersController < ApplicationController
  before_action :set_homepage_header, only: %i(edit update destroy activate)

  def index
    @homepage_headers = HomepageHeader.all
  end

  def new
    @homepage_header = HomepageHeader.new
  end

  def edit
  end

  def create
    @homepage_header = HomepageHeader.new(homepage_header_params)

    if @homepage_header.save
      redirect_to homepage_headers_url,
                  notice: 'Homepage Header wurde erstellt.'
    else
      render :new
    end
  end

  def update
    if @homepage_header.update(homepage_header_params)
      redirect_to homepage_headers_url,
                  notice: 'Homepage Header wurde aktualisiert.'
    else
      render :edit
    end
  end

  def destroy
    @homepage_header.destroy

    redirect_to homepage_headers_url, notice: 'Homepage Header wurde gelöscht.'
  end

  def activate
    if @homepage_header.activate
      flash.notice = 'Homepage Header wurde aktiviert.'
    else
      flash.alert = 'Homepage Header wurde nicht aktiviert: ' \
                    "#{@homepage_header.errors.full_messages.to_sentence}"
    end

    redirect_to homepage_headers_path
  end

  private

  def set_homepage_header
    @homepage_header = HomepageHeader.find(params[:id])
  end

  def homepage_header_params
    params.require(:homepage_header).permit(:background_image,
                                            :background_image_cache,
                                            :heading,
                                            :remove_background_image,
                                            :text)
  end
end
