require 'search_object/plugin/graphql'

module Resolvers
  # Class for implementing recipe searching with filters
  class RecipesSearch
    # Include SearchObject for GraphQL
    include SearchObject.module(:graphql)

    # Scope is starting point for search
    scope { Recipe.all }

    type types[Types::RecipeType]

    # Inline input type definition for the advance filter
    class RecipeFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :name_contains, String, required: false
      argument :description_contains, String, required: false
      argument :chef_id, ID, required: false
    end

    # When "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: RecipeFilter, with: :apply_filter
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
      scope = scope_by_value(value)
      branches << scope
      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?
      branches
    end

    private

    def scope_by_value(value)
      scope = Recipe.all
      scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]
      scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") if value[:description_contains]
      scope = scope.where('chef_id = ?', value[:chef_id]) if value[:chef_id]
      scope
    end
  end
end
