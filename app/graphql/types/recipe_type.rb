module Types
  # Defines RecipeType for GraphQL
  class RecipeType < Types::BaseObject
    field :id, ID, null: false
    field :chef_id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
  end
end
