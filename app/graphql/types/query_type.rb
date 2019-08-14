module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :all_chefs, [ChefType], null: false
    def all_chefs
      Chef.all
    end
  end
end
