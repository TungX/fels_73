module UsersHelper
  def avatar_for user
    avatar = user.avatar? ? user.avatar : Settings.default_avarta
    image_tag avatar, height: 60
  end
end
