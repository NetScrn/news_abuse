class Admin::ApplicationController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @users = User.last(5)
    @articles = Article.last(5)
    @comments = Comment.last(5)
  end

  private

    def authorize_admin
      authenticate_user!

      unless current_user.admin?
        redirect_to root_path, alert: "You must be an admin to do that."
      end
    end
end
