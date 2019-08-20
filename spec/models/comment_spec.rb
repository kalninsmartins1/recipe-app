require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:chef) { create(:chef) }
  let(:recipe) { chef.recipes.create!(attributes_for(:recipe)) }
  let(:comment) { create(:comment, chef_id: chef.id, recipe_id: recipe.id) }

  it 'latest comments are at the top' do
    other_comment = create(:comment_a, chef_id: chef.id, recipe_id: recipe.id)
    expect(Comment.first.id).to eq(other_comment.id)
  end

  context 'validation tests' do
    it 'chef_id is present' do
      comment.chef_id = ' '
      expect(comment.valid?).to eq(false)
    end

    it 'recipe_id is present' do
      comment.recipe_id = ' '
      expect(comment.valid?).to eq(false)
    end

    it 'description is present' do
      comment.description = ' '
      expect(comment.valid?).to eq(false)
    end

    it 'description is 4 to 140 characters long' do
      comment.description = 'a' * 3
      expect(comment.valid?).to eq(false)

      comment.description = 'a' * 141
      expect(comment.valid?).to eq(false)

      comment.description = 'a' * 50
      expect(comment.valid?).to eq(true)
    end
  end
end
