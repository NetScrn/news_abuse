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
      flash[:success] = "Статья была успешно создана."
      redirect_to @article
    else
      flash.now[:danger] = "Статья не была создана."
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
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :body)
    end
end
