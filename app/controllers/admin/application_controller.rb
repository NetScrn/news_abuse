class Admin::ApplicationController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @users = User.order(created_at: :desc).limit(5)
    @articles = Article.order(created_at: :desc).limit(5)
  end

  private

    def authorize_admin
      authenticate_user!

      unless current_user.admin?
        redirect_to root_url, alert: "You must be an admin to do that."
      end
    end
end
