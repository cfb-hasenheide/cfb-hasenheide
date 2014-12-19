class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  respond_to :html

  def index
    @news = user_signed_in? ? News.all : News.where(internal: false)
    respond_with(@news)
  end

  def show
    respond_with(@news)
  end

  def new
    @news = News.new
    respond_with(@news)
  end

  def edit
  end

  def create
    @news = News.new(news_params)
    flash[:notice] = 'News wurde erfolgreich erstellt.' if @news.save

    respond_with(@news, location: news_index_url)
  end

  def update
    if @news.update(news_params)
      flash[:notice] = 'News wurde erfolgreich aktualisiert.'
    end

    respond_with(@news, location: news_index_url)
  end

  def destroy
    @news.destroy
    respond_with(@news)
  end

  private
    def set_news
      @news = News.find(params[:id])
    end

    def news_params
      params.require(:news).permit(:title, :content, :internal)
    end
end
