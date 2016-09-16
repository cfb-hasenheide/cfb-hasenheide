class ForumPostsController < ApplicationController
  def create
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @forum_post = @forum_thread.forum_posts.build(forum_post_params)

    if @forum_post.save
      flash.notice = 'Eintrag erstellt.'
    else
      flash.alert = "Eintrag nicht erstellt: #{@forum_post.errors.full_messages.to_sentence}"
    end
    render 'forum_threads/show'
  end

  private

  def forum_post_params
    params.require(:forum_post).permit(:comment, :user_id, :forum_thread_id)
  end
end
