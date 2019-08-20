require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:chef) { create(:chef) }
  let!(:recipe) { build(:recipe, chef_id: chef.id) }

  context 'validation tests' do
    it 'chef id should not be nil' do
      recipe.chef_id = nil
      expect(recipe.valid?).to eq(false)
    end

    it 'recipe with name and description should be valid' do
      expect(recipe.valid?).to eq(true)
    end

    it 'name should be present' do
      recipe.name = ' '
      expect(recipe.valid?).to eq(false)
    end

    it 'name should not be shorter than 2 characters' do
      recipe.name = 'a'
      expect(recipe.valid?).to eq(false)
    end

    it 'name should not be longer than 20 characters' do
      recipe.name = 'a' * 21
      expect(recipe.valid?).to eq(false)
    end

    it 'description should be present' do
      recipe.description = ' '
      expect(recipe.valid?).to eq(false)
    end

    it 'description should not be shorter than 5 characters' do
      recipe.description = 'aaa'
      expect(recipe.valid?).to eq(false)
    end

    it 'description should not be longr than 500 characters' do
      recipe.description = 'a' * 501
      expect(recipe.valid?).to eq(false)
    end
  end

  context 'association tests' do
    it 'has many ingredients' do
      expect(recipe).to respond_to(:ingredients)
    end

    it 'has many comments' do
      expect(recipe).to respond_to(:comments)
    end

    it 'comments are deleted when recipe is deleted' do
      recipe.save!
      Comment.create(description: 'This is a comment', recipe_id: recipe.id, chef_id: chef.id)
      expect { recipe.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
