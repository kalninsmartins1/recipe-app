require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:chef) { create(:chef) }
  let(:recipe_a) { chef.recipes.create!(attributes_for(:recipe_a)) }
  let(:recipe_b) { chef.recipes.create!(attributes_for(:recipe_b)) }

  before(:each) do
    recipe_a.ingredients.create!(attributes_for(:ingredient))
    recipe_a.ingredients.create!(attributes_for(:ingredient_a))
    recipe_b.ingredients.create!(attributes_for(:ingredient_b))
  end

  it 'has many recipes' do
    expect(RecipeIngredient.select(:recipe_id).distinct.count).to eq(2)
  end

  it 'has many ingrdients' do
    expect(RecipeIngredient.select(:ingredient_id).distinct.count).to eq(3)
  end
end
