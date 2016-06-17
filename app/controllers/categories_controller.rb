class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page], per_page: 9)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 10)
  end
end
