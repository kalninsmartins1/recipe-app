# Null object pattern for Ricepe record
# Placeholder for when there is no Recipe record.
class NullRecipeRecord
  def id
    -1
  end

  def name
    'N/A'
  end

  def update(params); end

  def chef
    NullChefRecord.new
  end
end
