module Mutations
  # GrapQL mutation for creating new chefs
  class CreateChef < BaseMutation
    # Arguments passed to the 'resolved' method
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    # Return type from the mutation
    type Types::ChefType

    def resolve(name: nil, email: nil, password: nil)
      Chef.create!(name: name, email: email, password: password)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
