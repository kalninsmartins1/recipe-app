require 'rails_helper'

RSpec.describe RecentlyUpdatedRecipesQuery do
  let(:chef) { create(:chef) }

  it 'recipes are ordered in descending order' do
    recipe_a = create(:recipe_a, chef_id: chef.id, created_at: 2.days.ago, updated_at: 1.day.ago)
    recipe_b = create(:recipe_b, chef_id: chef.id, created_at: 3.days.ago, updated_at: 2.hours.ago)
    recipes = RecentlyUpdatedRecipesQuery.recipes

    expect(recipes.first.id).to eq(recipe_b.id)
    expect(recipes.second.id).to eq(recipe_a.id)
  end
end
