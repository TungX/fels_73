class WordsController < ApplicationController
  def index
    @categories = Category.all
    if !params[:category_id].nil? && params[:category_id].empty?
      @words = Word.send params[:option], current_user.id
    elsif category = @categories.detect{|category| category.id == params[:category_id].to_i}
      @words = category.words.send params[:option], current_user.id
    else
      @words = []
    end
  end
end
