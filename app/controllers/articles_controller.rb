class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = I18n.t(:art_created)
      redirect_to @article
    else
      flash.now[:danger] = I18n.t(:art_n_created)
      render "new"
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Статья успешно обновлена"
      redirect_to @article
    else
      flash.now[:danger] = "Статья не была обновлена"
      render "new"
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :body)
    end
end
