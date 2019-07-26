require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  before(:each) do
    chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
    recipe1 = chef.recipes.create(name: 'Baked sweet patatoes', description: '1. Cut in slices;2.Bake in oven for 20 min')
    recipe2 = chef.recipes.create(name: 'Bake pumpkin', description: 'Bake it !')

    recipe1.ingredients.create(name: 'Sweet potatoe')
    recipe1.ingredients.create(name: 'Coconut oil')
    recipe2.ingredients.create(name: 'Pumpkin')
  end

  it 'has many recipes' do
    expect(RecipeIngredient.select(:recipe_id).distinct.count).to eq(2)
  end

  it 'has many ingrdients' do
    expect(RecipeIngredient.select(:ingredient_id).distinct.count).to eq(3)
  end
end
