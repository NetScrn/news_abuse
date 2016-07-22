class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page], per_page: 9)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.confirmed.paginate(page: params[:page], per_page: 10)
  end

  def new
    @categories = Category.all
    @index = params[:index].to_s
    render layout: false
  end
end
