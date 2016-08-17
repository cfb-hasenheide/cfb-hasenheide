class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = 'Kommentar wurde erstellt'
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end

    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment)
      .permit(:commentable_id, :commentable_type, :content, :user_id)
  end
end
