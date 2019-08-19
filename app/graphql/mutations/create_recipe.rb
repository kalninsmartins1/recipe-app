module Mutations
  # GrapQL mutation for creating new recipe
  class CreateRecipe < BaseMutation
    # Arguments passed to the 'resolved' method
    argument :name, String, required: true
    argument :description, String, required: true
    argument :chef_id, ID, required: true

    # Return type from the mutation
    type Types::RecipeType

    def resolve(name: nil, description: nil, chef_id: nil)
      Recipe.create!(name: name, description: description, chef_id: chef_id)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
