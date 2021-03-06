class Admin::WordsController < ApplicationController
  before_action :load_category, only: [:create, :update]
  before_action :load_word, only: [:show, :edit]

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "word_created"
      redirect_to admin_word_path @word
    else
      @words = @category.words.paginate page: params[:page]
      @word.answers.build if @word.answers.empty?
      render "admin/categories/show"
    end
  end

  def show
  end

  def edit
  end

  def update
    @word = Word.find_by id: params[:id]
    if @word && @word.update_attributes(word_params)
      flash[:success] = t "word_updated"
      redirect_to admin_word_path @word
    else
      render "admin/words/edit"
    end
  end

  def destroy
    word = Word.find_by id: params[:id]
    if word
      word.destroy
      flash[:success] = t "word_destroy"
      redirect_to admin_category_path word.category
    else
      redirect_to admin_categories_path
    end
  end

  private
  def word_params
    params.require(:word).permit(:id ,:content, :image, :sound,
      answers_attributes: [:id, :content, :is_correct, :_destroy])
  end

  def load_category
    @category = Category.find_by id: params[:word][:category_id]
    redirect_to admin_categories_path unless @category
  end

  def load_word
    @word = Word.find_by id: params[:id]
    redirect_to admin_categories_path unless @word
  end
end
