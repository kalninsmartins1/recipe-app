# Controlling the routes for recipes
class RecipesController < ApplicationController
  attr_writer :recipe
  before_action :require_chef, except: [:index, :show]
  before_action :require_admin_or_same_chef, only: [:update, :edit, :destroy]

  def index
    @recipes = RecentlyUpdatedRecipesQuery.recipes.paginate(page: params[:page], per_page: 5)
  end

  def show
    @comment = Comment.new
    @comments = recipe.comments.paginate(page: params[:page], per_page: 5)
  end

  def new
    self.recipe = Recipe.new
  end

  def create
    self.recipe = Recipe.new(recipe_params)
    recipe.chef = current_chef
    if recipe.save
      redirect_to recipe_path(recipe)
      flash[:success] = 'Recipe created successfully !'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if recipe.update(recipe_params)
      flash[:success] = 'Recipe was updated successfully !'
      redirect_to recipe_path(recipe)
    else
      render 'edit'
    end
  end

  def destroy
    if recipe.destroy
      flash[:success] = 'Recipe has been sucessfuly deleted !'
      redirect_to recipes_path
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def require_admin_or_same_chef
    return if current_chef.id == recipe.chef_id || current_chef.admin?

    flash[:danger] = 'You cant perform this action on other chefs recipes !'
    redirect_to recipes_path
  end

  def recipe
    @recipe ||= ValidRecipeDecorator.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, ingredient_ids: [])
  end
end
