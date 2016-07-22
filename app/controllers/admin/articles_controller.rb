class Admin::ArticlesController < Admin::ApplicationController
  def index
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def confirm
    @article = Article.find(params[:id])
    if @article.confirmed?
      flash[:warning] = "The article has already been confirmed"
    else
      @article.confirm
      flash[:success] = "Article has been confirmed"
    end
    redirect_to :back
  end

  def reject
    @article = Article.find(params[:id])
    if @article.confirmed?
      flash[:warning] = "The article has already been confirmed"
    else
      @article.reject
      flash[:success] = "Article has been rejected and deleted"
    end
    redirect_to :back
  end

  def delete
  end
end
