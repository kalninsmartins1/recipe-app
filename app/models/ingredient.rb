# Represents ingredient data model
class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates_presence_of :name
  validates_length_of :name, within: 5..25
  validates_uniqueness_of :name, case_sensitive: false
end
