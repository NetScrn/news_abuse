class ArticlesController < ApplicationController
  before_action :set_article, except: [:new, :create]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    build_categories_for(@article)
    if @article.save
      flash[:success] = I18n.t(:article_created)
      redirect_to @article
    else
      flash.now[:danger] = I18n.t(:article_n_created)
      render "new"
    end
  end

  def show
    @comments = @article.comments
  end

  def edit
  end

  def update
    build_categories_for(@article)
    if @article.update(article_params)
      flash[:success] = t(:article_updated)
      redirect_to @article
    else
      flash.now[:danger] = t(:article_n_updated)
      render "edit"
    end
  end

  def destroy
    @article.destroy
    flash[:success] = t(:article_deleted)
    redirect_to categories_url
  end

  private

    def article_params
      params.require(:article).permit(:title, :description, :body)
    end

    def build_categories_for(article)
      ids = params.fetch(:categories, []).reject {|k,v| v == ""}.map {|k,v| v.to_i}
      article.category_ids = ids if ids.any?
    end


    # BEFORE ACTIONS
    def set_article
      @article = Article.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
end
