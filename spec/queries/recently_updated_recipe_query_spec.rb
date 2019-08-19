require 'rails_helper'

RSpec.describe RecentlyUpdatedRecipesQuery do
  let(:chef) { Chef.create!(name: 'Jim', email: 'jim123@test.com', password: 'password') }

  it 'recipes are ordered in descending order' do
    recipe_a = chef.recipes.create!(name: 'Coconut', description: 'Break the shell !', created_at: 2.days.ago, updated_at: 1.day.ago)
    recipe_b = chef.recipes.create!(name: 'Cucumber', description: 'Wash it.', created_at: 3.days.ago, updated_at: 2.hours.ago)
    recipes = RecentlyUpdatedRecipesQuery.recipes

    expect(recipes.first.id).to eq(recipe_b.id)
    expect(recipes.second.id).to eq(recipe_a.id)
  end
end
