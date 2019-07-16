# Recipe model decorator to ensure a valid object is always returned.
class ValidRecipeDecorator
  def self.find(id)
    Recipe.find(id)
  rescue ActiveRecord::RecordNotFound
    NullRecipeRecord.new
  end

  def self.find_by(hash)
    Recipe.find_by(hash) || NullRecipeRecord.new
  end
end
