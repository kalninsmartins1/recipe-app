require 'rails_helper'

RSpec.describe 'ValidIngredientDecorator' do
  let(:ingredient) do
    chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole')
    recipe = chef.recipes.create(name: 'Baked sweet patatoe', description: 'Put sweet potatoes in oven')
    recipe.ingredients.create(name: 'Sweet patatoe')
  end

  context 'find method' do
    it 'should return NullIngredientRecord when no Ingredient has been found' do
      expect(ValidIngredientDecorator.find(-1)).to be_an_instance_of(NullIngredientRecord)
    end

    it 'shuld return valid chef when existing id provided' do
      expect(ValidIngredientDecorator.find(ingredient.id).name).to eq(ingredient.name)
    end
  end
end
