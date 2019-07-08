class Recipe < ApplicationRecord
  belongs_to :chef
  validates :name, presence: true, length: {minimum:3, maximum:20}
  validates :description, presence: true, length: {minimum:5, maximum:500}

  default_scope { order(updated_at: :desc) }
end