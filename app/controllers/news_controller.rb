class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  respond_to :html

  def index
    news = News.order(created_at: :desc)
    news = news.where(internal: false) unless user_signed_in?
    @news = news.page(params[:page]).per(5)
    @news_by_month = news_by_month

    respond_with(@news)
  end

  def show
    authenticate_user! if @news.internal?
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

  def news_params
    params.require(:news).permit(:title, :content, :internal)
  end

  def news_by_month
    News.order(created_at: :desc)
        .select(:created_at, :title, :id)
        .group_by { |n| n.created_at.beginning_of_month }
  end

  def set_news
    @news = News.find(params[:id])
  end
end
