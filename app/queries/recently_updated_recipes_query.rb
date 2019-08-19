# Class for fetching recipes in decending order by :updated_at attribute
class RecentlyUpdatedRecipesQuery
  def self.recipes
    Recipe.all.order(updated_at: :desc)
  end
end
