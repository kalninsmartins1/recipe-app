# Decorator for Ingredient model, ensuring a valid object is always returned.
class ValidIngredientDecorator
  def self.find(id)
    Ingredient.find(id)
  rescue ActiveRecord::RecordNotFound
    NullIngredientRecord.new
  end
end
