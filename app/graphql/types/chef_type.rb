module Types
  # Defines ChefType for GraphQL
  class ChefType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
  end
end
