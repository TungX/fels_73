module UsersHelper
  def avatar_for user
    avatar = user.avatar? ? user.avatar : Settings.default_avatar
    image_tag avatar, height: 60
  end

  def require_admin
    unless signed_in? && current_user.admin?
      sign_out
      flash[:danger] = t "request_signin_admin"
      redirect_to signin_path
    end
  end
end
