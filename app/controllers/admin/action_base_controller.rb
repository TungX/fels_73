class Admin::ActionBaseController < ApplicationController
  before_action :require_admin
  private
  def require_admin
    unless signed_in? && current_user.admin?
      sign_out
      flash[:danger] = t "request_signin_admin"
      redirect_to signin_path
    end
  end
end
