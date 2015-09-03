class StaticPagesController < ApplicationController
  before_action :authorize_user, only: [:home]

  def home
    @activities = current_user.load_activities.paginate page: params[:page], per_page:10
  end

  def help
  end

  def about
  end

  private
  def authorize_user
    unless signed_in?
      render "welcome"
    end
  end
end
