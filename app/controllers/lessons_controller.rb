class LessonsController < ApplicationController
  before_action :authorize_user
  before_action :load_category, only: [:create]
  before_action :load_lesson, only: [:show]

  def show
    @words = @lesson.words
  end

  def create
    @lesson = current_user.lessons.new category_id: @category.id
    if @lesson.save
      flash[:success] = t "create_lesson_complete"
      redirect_to @lesson
    else
      flash[:danger] = t "create_lesson_fail"
      redirect_to categories_path
    end
  end

  private
  def authorize_user
    unless signed_in?
      flash[:danger] = t "request_signin"
      redirect_to signin_path
    end
  end

  def load_category
    @category = Category.find_by id: params[:lesson][:category_id]
    redirect_to categories_path unless @category
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    redirect_to categories_path unless @lesson
  end
end
