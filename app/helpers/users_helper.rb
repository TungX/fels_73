module UsersHelper
  def avatar_for user, options = {size: 80}
    avatar = user.avatar? ? user.avatar : Settings.default_avatar
    image_tag avatar, height: :size
  end
end
