require 'rails_helper'

RSpec.describe 'ValidRecipeDecorator' do
  let(:chef) { create(:chef) }
  let(:recipe) { chef.recipes.create(attributes_for(:recipe)) }

  context 'find method' do
    it 'return NullRecipeRecord when record not found' do
      expect(ValidRecipeDecorator.find(-1)).to be_an_instance_of(NullRecipeRecord)
    end

    it 'return correct record when valid id provided' do
      expect(ValidRecipeDecorator.find(recipe.id).name).to eq(recipe.name)
    end
  end

  context 'find_by method' do
    it 'return NullRecipeRecord when record not found' do
      expect(ValidRecipeDecorator.find_by(name: '')).to be_an_instance_of(NullRecipeRecord)
    end

    it 'return correct record when valid attribute provided' do
      expect(ValidRecipeDecorator.find_by(name: recipe.name).id).to eq(recipe.id)
    end
  end
end
