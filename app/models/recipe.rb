class Recipe < ApplicationRecord
  belongs_to :chef
  has_many :recipe_ingredients
  has_many :comments, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true
  validates :name, length: {within: 3..20}

  validates :description, presence: true
  validates :description, length: {within: 5..500}

  default_scope { order(updated_at: :desc) }
end