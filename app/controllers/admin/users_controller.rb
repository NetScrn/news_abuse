class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.all
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 40)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.created_at = Time.now
    @user.skip_confirmation!
    if @user.save
      flash[:success] = "User has been created."
      redirect_to admin_users_url
    else
      flash[:danger] = "User has not been created."
      render "new"
    end
  end

  def show
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(user_params)
      flash[:success] = "User has been updated."
      redirect_to admin_users_url
    else
      flash[:danger] = "User has not been updated."
      render "show"
    end
  end

  def archive
    if @user == current_user
      flash[:danger] = "You cannot archive youself!"
    else
      @user.archive
      flash[:notice] = "User has been archived"
    end

    redirect_to :back
  end

  def restore
    @user.restore
    flash[:notice] = "User has been restored"
    redirect_to :back
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :admin,
        :password_confirmation)
    end

    # BEFORE ACTIONS

    def set_user
      @user = User.find(params[:id])
    end
end
