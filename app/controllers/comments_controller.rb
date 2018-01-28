class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    authorize! :create, Comment

    @comment = Comment.new(comment_params)

    if @comment.save
      flash.notice = 'Kommentar wurde erstellt'
    else
      flash.alert = @comment.errors.full_messages.to_sentence
    end

    redirect_back fallback_location: root_path
  end

  def edit
  end

  def update
    authorize! :update, Comment

    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: 'Kommentar aktualisiert'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, Comment

    @comment.destroy
    redirect_to @comment.commentable, notice: 'Kommentar gelöscht'
  end

  private

  def comment_params
    params.require(:comment)
          .permit(:commentable_id, :commentable_type, :content, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
