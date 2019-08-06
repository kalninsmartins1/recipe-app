# Controlling the routes for recipes
class RecipesController < ApplicationController
  before_action :init_recipe, only: [:show, :update, :edit, :destroy]
  before_action :require_chef, except: [:index, :show]
  before_action :require_admin_or_same_chef, only: [:update, :edit, :destroy]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      redirect_to recipe_path(@recipe)
      flash[:success] = 'Recipe created successfully !'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = 'Recipe was updated successfully !'
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    return unless @recipe.destroy

    flash[:success] = 'Recipe has been sucessfuly deleted !'
    redirect_to recipes_path
  end

  private

  def require_admin_or_same_chef
    return if current_chef.id == @recipe.chef.id || current_chef.admin?

    flash[:danger] = 'You cant perform this action on other chefs recipes !'
    redirect_to recipes_path
  end

  def init_recipe
    @recipe = ValidRecipeDecorator.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
