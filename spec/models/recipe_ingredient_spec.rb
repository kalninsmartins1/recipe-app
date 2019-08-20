require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:chef) { Chef.create!(name: 'Peter', email: 'peter12@awesome.com', password: 'parole') }
  let(:recipe_a) { chef.recipes.create!(name: 'Baked sweet patatoes', description: '1. Cut in slices;2.Bake in oven for 20 min') }
  let(:recipe_b) { chef.recipes.create!(name: 'Bake pumpkin', description: 'Bake it !') }

  before(:each) do
    recipe_a.ingredients.create!(name: 'Sweet potatoe')
    recipe_a.ingredients.create!(name: 'Coconut oil')
    recipe_b.ingredients.create!(name: 'Pumpkin')
  end

  it 'has many recipes' do
    expect(RecipeIngredient.select(:recipe_id).distinct.count).to eq(2)
  end

  it 'has many ingrdients' do
    expect(RecipeIngredient.select(:ingredient_id).distinct.count).to eq(3)
  end
end
