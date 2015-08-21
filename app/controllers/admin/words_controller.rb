class Admin::WordsController < ApplicationController
  before_action :load_category, only: [:create]

  def create
    @word = @category.words.new word_params
    if @word.save
      redirect_to admin_category_path @category
    else
      render "admin/categories/show"
    end
  end

  private
  def word_params
    params.require(:word).permit(:content, :image, :sound)
  end

  def load_category
    @category = Category.find_by id: params[:id]
    redirect_to categories_path unless @category
  end
end
