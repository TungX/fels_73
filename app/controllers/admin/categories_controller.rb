class Admin::CategoriesController < Admin::ActionBaseController
  before_action :load_category, only: [:show, :edit, :update]

  def index
    @categories = Category.paginate page: params[:page]
    @category = Category.new
  end

  def show
    @word = @category.words.new
    Settings.number_answers.times{@word.answers.build}
    @words = @category.words.paginate page: params[:page]
    redirect_to admin_category_path(@category), status: :move_permanently unless
      request.path == admin_category_path(@category)
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_category_complete"
      redirect_to admin_categories_path
    else
      @categories = Category.paginate page: params[:page]
      render "index"
    end
  end

  def edit
    redirect_to edit_admin_category_path(@category), status: :move_permanently unless
      request.path == edit_admin_category_path(@category)
  end

  def update
    byebug
    if @category && @category.update_attributes(category_params)
      flash[:success] = t "profile_updated"
      redirect_to admin_category_path @category
    else
      render :edit
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end

  def load_category
     @category = Category.friendly.find params[:id]
  end
end
