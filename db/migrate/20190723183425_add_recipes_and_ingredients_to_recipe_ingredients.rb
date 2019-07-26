# Migration for adding recipe and ingredient id columns to RecipeIngredient table
class AddRecipesAndIngredientsToRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :recipe_ingredients, :recipe_id, :integer
    add_column :recipe_ingredients, :ingredient_id, :integer
  end
end
