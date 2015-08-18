class Admin::CategoriesController < ApplicationController
  before_action :require_admin
  def index
    @categories = Category.paginate page: params[:page]
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_category_complete"
      redirect_to admin_categories_path
    else
      @categories = Category.paginate page: params[:page]
      render "index"
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end

  def require_admin
    unless signed_in? && current_user.admin?
      sign_out
      flash[:danger] = t "request_signin_admin"
      redirect_to signin_path
    end
  end
end
