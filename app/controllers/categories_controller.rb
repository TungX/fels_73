class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate page: params[:page]
  end

  def show
    @category = Category.find_by id: params[:id]
    @lessons = Lesson.paginate page: params[:page], per_page:10
  end
end
