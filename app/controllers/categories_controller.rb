class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page]
  end

  def show
    @category = Category.find_by(id: params[:id])|| Category.find_by(slug: params[:id])
  end
end
