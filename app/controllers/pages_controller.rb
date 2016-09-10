class PagesController < PublicController
  before_action :set_events, :set_news, only: :welcome
  before_action :set_page, only: %i(show edit update destroy)

  def index
    authorize!(:read, Page)

    @pages = Page.order(:slug, :published).page(params[:page])
  end

  def show
    authorize!(:read, Page)

    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        autolink: true,
                                        tables: true)
  end

  def new
    authorize!(:create, Page)

    @page = Page.new
  end

  def create
    authorize!(:create, Page)

    @page = Page.new(page_params)

    if @page.save
      redirect_to page_path(@page), notice: 'Seite erstellt.'
    else
      render :new
    end
  end

  def edit
    authorize!(:update, Page)
  end

  def update
    authorize!(:update, Page)

    if @page.update(page_params)
      redirect_to page_path(@page)
    else
      render :edit
    end
  end

  def destroy
    authorize!(:destroy, Page)

    slug = @page.slug
    @page.destroy
    redirect_to pages_path, notice: "Seite #{slug} gelöscht."
  end

  def welcome
  end

  def fussball_de
  end

  def contact
  end

  private

  def page_params
    params.require(:page).permit(:slug, :header, :subheader, :content, :public)
  end

  def set_events
    events = Event.all
    events = events.where(public: true) unless user_signed_in?
    @past_events = events.past(3)
    @future_events = events.future(3)
  end

  def set_news
    news = News.all
    news = news.where(internal: false) unless user_signed_in?
    @news = news.order('created_at DESC').limit(5)
  end

  def set_page
    @page = Page.friendly.find(params[:id])
  end
end
