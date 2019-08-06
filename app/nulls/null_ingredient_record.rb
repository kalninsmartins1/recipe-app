# Null object pattern for Ingredient record.
# Placeholder for when there is no ingredient record.
class NullIngredientRecord
  def update(_params)
    false
  end

  def id
    -1
  end
end
