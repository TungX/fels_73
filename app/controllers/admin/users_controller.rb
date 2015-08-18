class Admin::UsersController < ApplicationController
  before_action :require_admin
  def index
    @users = User.paginate page: params[:page], per_page:10
  end

  def destroy
    user = User.find_by id: params[:id]
    if user.id != current_user.id
      user.destroy
    end
    redirect_to users_path
  end
end
