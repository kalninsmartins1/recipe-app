require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'validation tests' do
    before(:each) do
      chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com')
      @recipe = Recipe.new(name: 'Baked sweet patatoes', description: '1. Cut in slices;2.Bake in oven for 20 min', chef_id: chef.id)
    end

    it 'chef id should not be nil' do
      @recipe.chef_id = nil
      expect(@recipe.valid?).to eq(false)
    end

    it 'recipe with name and description should be valid' do
      expect(@recipe.valid?).to eq(true)
    end

    it 'name should be present' do
      @recipe.name = ' '
      expect(@recipe.valid?).to eq(false)
    end

    it 'name should not be shorter than 2 characters' do
      @recipe.name = 'a'
      expect(@recipe.valid?).to eq(false)
    end

    it 'name should not be longer than 20 characters' do
      @recipe.name = 'a' * 21
      expect(@recipe.valid?).to eq(false)
    end

    it 'description should be present' do
      @recipe.description = ' '
      expect(@recipe.valid?).to eq(false)
    end

    it 'description should not be shorter than 5 characters' do
      @recipe.description = 'aaa'
      expect(@recipe.valid?).to eq(false)
    end

    it 'description should not be longr than 500 characters' do
      @recipe.description = 'a' * 501
      expect(@recipe.valid?).to eq(false)
    end
  end
end
