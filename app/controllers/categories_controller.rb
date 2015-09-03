class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page]
  end

  def show
    @category = Category.friendly.find params[:id]
    redirect_to @category, status: :move_permanently unless
      request.path == category_path(@user)
  end
end
