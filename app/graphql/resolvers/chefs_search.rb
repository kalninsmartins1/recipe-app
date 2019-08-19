require 'search_object/plugin/graphql'

module Resolvers
  # Class for implementing chef searching with filters
  class ChefsSearch
    # Include SearchObject for GraphQL
    include SearchObject.module(:graphql)

    # Scope is starting point for search
    scope { Chef.all }

    type types[Types::ChefType]

    # Inline input type definition for the advance filter
    class ChefFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :name_contains, String, required: false
      argument :email_contains, String, required: false
    end

    # When "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: ChefFilter, with: :apply_filter
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip

    def apply_first(scope, value)
      scope.limit(value)
    end

    def apply_skip(scope, value)
      scope.offset(value)
    end

    # apply_filter recursively loops through "OR" branches
    def apply_filter(scope, value)
      branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end

    def normalize_filters(value, branches = [])
      scope = Chef.all
      scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]
      scope = scope.where('email LIKE ?', "%#{value[:email_contains]}%") if value[:email_contains]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
