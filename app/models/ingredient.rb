# Represents ingredient data model
class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true
  validates :name, length: {within: 5..25}
  validates :name, uniqueness: {case_sensitive: false}
end
