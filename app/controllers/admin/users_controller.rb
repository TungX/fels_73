class Admin::UsersController < Admin::ActionBaseController
  def index
    @users = User.paginate page: params[:page], per_page:10
  end

  def destroy
    user = User.find_by(id: params[:id])|| User.find_by(slug: params[:id])
    if user.id != current_user.id
      user.destroy
    end
    redirect_to admin_users_path
  end
end
