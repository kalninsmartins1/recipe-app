# Class representing comment in data storage
class Comment < ApplicationRecord
  belongs_to :chef
  belongs_to :recipe

  validates :description, presence: true
  validates :description, length: {within: 4..140}
end
