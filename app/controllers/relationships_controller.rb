class RelationshipsController < ApplicationController
  before_action :load_user, only: :index

  def index
    send params[:option]
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  Settings.follow_methods.each do |method_name|
    define_method method_name do
      @title = t "#{method_name}"
      @users = @user.send(method_name).paginate page: params[:page]
    end
  end

  def load_user
    @user = User.find_by(id: params[:user_id]) || User.find_by(slug: params[:user_id])
  end
end
