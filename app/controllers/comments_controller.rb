class CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.author = current_user if current_user
    if @comment.save
      redirect_to @article, notice: t(:comment_created)
    else
      flash[:danger] = t(:comment_not_created)
      redirect_to @article
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
