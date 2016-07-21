class Admin::ArticlesController < Admin::ApplicationController
  def index
    @articles = Article.all.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def confirm
  end

  def edit
  end

  def update
  end

  def delete
  end
end
