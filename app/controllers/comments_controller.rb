class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      ActionCable.server.broadcast('comments_channel', render_comment(@comment))
      flash[:notice] = 'Comment has been created'
    else
      flash.now[:alert] = 'Comment has not been created'
    end
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def render_comment(comment)
    CommentsController.render(partial: 'comments/comment', object: comment)
  end
end
