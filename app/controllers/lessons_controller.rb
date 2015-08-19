class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find_by params[:id]
    redirect_to categories_path unless @lesson
  end
end
