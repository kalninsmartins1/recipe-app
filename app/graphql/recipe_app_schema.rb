# GraphQL schema for recipe app
class RecipeAppSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
