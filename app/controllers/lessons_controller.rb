class LessonsController < ApplicationController
  before_action :authorize_user
  before_action :load_category, only: [:create]
  before_action :check_lesson_comlete, only: [:create]
  before_action :load_lesson, only: [:show]

  def show
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

  def update
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.update_attributes lesson_params
      flash[:success] = t "update_lesson_complete"
    else
      flash[:danger] = t "update_lesson_fail"
    end
    redirect_to @lesson
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

  def check_lesson_comlete
    @lesson = current_user.lessons.not_learn(@category.id).first
    redirect_to @lesson if @lesson
  end

  def lesson_params
    params.require(:lesson).permit :learned, lesson_words_attributes: [:id, :answer_id]
  end
end
