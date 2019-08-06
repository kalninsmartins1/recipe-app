# Class controlling access to Ingredient model
class IngredientsController < ApplicationController
  before_action :init_ingredient, only: [:show, :update, :edit]
  before_action :require_admin, except: [:index, :show]

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = 'Ingredient successfully created !'
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = 'Ingredient successfully updated !'
      redirect_to ingredient_path(@ingredient)
    else
      render 'edit'
    end
  end

  private

  def require_admin
    return if current_chef.admin?

    flash[:danger] = 'This action was not allowed !'
    redirect_to ingredients_path
  end

  def init_ingredient
    @ingredient = ValidIngredientDecorator.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
