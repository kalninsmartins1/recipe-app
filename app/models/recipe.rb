class Recipe < ApplicationRecord
  belongs_to :chef
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates_presence_of :name
  validates_length_of :name, within: 3..20

  validates_presence_of :description
  validates_length_of :description, within: 5..500

  default_scope { order(updated_at: :desc) }
end