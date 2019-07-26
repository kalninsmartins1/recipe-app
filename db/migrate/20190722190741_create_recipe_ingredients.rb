# Migration for creating RecipeIngredient table
class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients, &:timestamps
  end
end
