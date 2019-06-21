# Controlling the routes for recipes
class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    if @recipe.save
      redirect_to recipe_path(@recipe)
      flash[:success] = 'Recipe created successfully !'
    else
      render 'new'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
