class CategoriesController < ApplicationController
  before_action :authorize_user, only: [:create]
  def index
    @categories = Category.paginate page: params[:page]
  end

  def show
    @category = Category.find_by id: params[:id]
  end
end
