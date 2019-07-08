# Controlling the routes for recipes
class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :update, :edit, :destroy]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first # Todo change to logged in chef
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

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
