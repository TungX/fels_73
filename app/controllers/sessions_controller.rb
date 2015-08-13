class SessionsController < ApplicationController
  def new
    redirect_to current_user if signed_in?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      sign_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t 'error_sigin'
      render :new
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end
end
