class ForumThreadsController < ApplicationController
  before_action :set_forum_thread, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @forum_threads = ForumThread.order('created_at DESC')
    respond_with(@forum_threads)
  end

  def show
    respond_with(@forum_thread)
  end

  def new
    @forum_thread = ForumThread.new
    respond_with(@forum_thread)
  end

  def edit
  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    @forum_thread.save
    respond_with(@forum_thread, location: forum_threads_path)
  end

  def update
    @forum_thread.update(forum_thread_params)
    respond_with(@forum_thread)
  end

  def destroy
    @forum_thread.destroy
    respond_with(@forum_thread)
  end

  private
    def set_forum_thread
      @forum_thread = ForumThread.find(params[:id])
    end

    def forum_thread_params
      params.require(:forum_thread).permit(:topic, :comment, :user_id)
    end
end
