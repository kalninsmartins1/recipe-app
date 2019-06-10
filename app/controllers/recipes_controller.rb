# Controlling the routes for recipes
class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end
end
