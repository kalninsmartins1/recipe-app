# Model for tying many to many relationship between recipes and ingredients
class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
end
