require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  context 'show method' do
    it 'assign comment' do
      chef = Chef.create(name: 'Peter', email: 'peter12@test.lv', password: 'password')
      recipe = Recipe.create(name: 'Carrot soup', description: 'Chop carrots...', chef_id: chef.id)

      get :show, params: {id: recipe.id}

      comment = Comment.new
      expect(assigns(:comment).id).to eq(comment.id)
    end
  end
end
