module Types
  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  class QueryType < Types::BaseObject
    field :all_chefs, function: Resolvers::ChefsSearch
    field :all_recipes, function: Resolvers::RecipesSearch
  end
end
