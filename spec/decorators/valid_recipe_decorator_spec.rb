require 'rails_helper'

RSpec.describe 'ValidRecipeDecorator' do
  before(:each) do
    chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
    @recipe = Recipe.new(name: 'Baked sweet patatoes', description: '1. Cut in slices;2.Bake in oven for 20 min', chef_id: chef.id)
    @recipe.save!
  end

  context 'find method' do
    it 'return NullRecipeRecord when record not found' do
      expect(ValidRecipeDecorator.find(-1)).to be_an_instance_of(NullRecipeRecord)
    end

    it 'return correct record when valid id provided' do
      expect(ValidRecipeDecorator.find(@recipe.id).name).to eq(@recipe.name)
    end
  end

  context 'find_by method' do
    it 'return NullRecipeRecord when record not found' do
      expect(ValidRecipeDecorator.find_by(name: '')).to be_an_instance_of(NullRecipeRecord)
    end

    it 'return correct record when valid attribute provided' do
      expect(ValidRecipeDecorator.find_by(name: @recipe.name).id).to eq(@recipe.id)
    end
  end
end
