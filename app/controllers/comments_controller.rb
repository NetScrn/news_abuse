class CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_article
  before_action :set_comment, except: :create
  before_action :authorize_destroy, only: :destroy

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

  def subcomment
    render layout: false
  end

  def create_subcomment
    @subcomment = Comment.new(comment_params)
    @subcomment.parent = @comment
    @subcomment.article = @article
    @subcomment.author = current_user if current_user
    if @subcomment.save
      redirect_to @article, notice: t(:comment_created)
    else
      flash[:danger] = t(:comment_not_created)
      redirect_to @article
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = t(:comment_deleted)
    redirect_to @article
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def authorize_destroy
      return authorize_failed if current_user == nil
      if @article.author != current_user && current_user != @comment.author
        return authorize_failed
      end
    end

    def authorize_failed
      flash[:danger] = t(:dont_allow_delete_comment)
      redirect_to @article
    end
end
