module Types
  # Defines available grapql mutations
  class MutationType < Types::BaseObject
    field :create_chef, mutation: Mutations::CreateChef
    field :create_recipe, mutation: Mutations::CreateRecipe
  end
end
