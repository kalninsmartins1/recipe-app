# Persistant storage representation of message
class Message < ApplicationRecord
  belongs_to :chef

  validates :content, length: {within: 1..200}
end
