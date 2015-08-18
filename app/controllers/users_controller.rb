class UsersController < ApplicationController
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page:10
  end

  def show
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
  end

  def new
    sign_out if signed_in?
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = t "webcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    redirect_to root_path unless @user
  end

  def update
    if @user && @user.update_attributes(user_params)
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find_by id: params[:id]
    if user && user.id != current_user && current_user.admin?
      user.destroy
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
  end

  def authorize_user
    unless signed_in?
      flash[:danger] = t "request_signin"
      redirect_to signin_path
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end
end
