module Types
  class MutationType < Types::BaseObject
    field :create_chef, mutation: Mutations::CreateChef
  end
end
