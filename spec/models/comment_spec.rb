require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @chef = Chef.create(name: 'John', email: 'john@test.com', password: 'password')
    @recipe = @chef.recipes.create(name: 'Boiled buckwheat', description: '20 minutes boil in water')
    @comment = Comment.create(description: 'This is a great recipe !', chef_id: @chef.id, recipe_id: @recipe.id)
  end

  it 'latest comments are at the top' do
    @comment = Comment.create(description: 'I still like it !', chef_id: @chef.id, recipe_id: @recipe.id)
    @comment.save!
    puts @comment.updated_at
    puts Comment.first.updated_at
    expect(Comment.first.id).to eq(@comment.id)
  end

  context 'validation tests' do
    it 'chef_id is present' do
      @comment.chef_id = ' '
      expect(@comment.valid?).to eq(false)
    end

    it 'recipe_id is present' do
      @comment.recipe_id = ' '
      expect(@comment.valid?).to eq(false)
    end

    it 'description is present' do
      @comment.description = ' '
      expect(@comment.valid?).to eq(false)
    end

    it 'description is 4 to 140 characters long' do
      @comment.description = 'a' * 3
      expect(@comment.valid?).to eq(false)

      @comment.description = 'a' * 141
      expect(@comment.valid?).to eq(false)

      @comment.description = 'a' * 50
      expect(@comment.valid?).to eq(true)
    end
  end
end
