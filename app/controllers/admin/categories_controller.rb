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
      redirect_to categories_path
    else
      @categories = Category.paginate page: params[:page]
      render "index"
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
