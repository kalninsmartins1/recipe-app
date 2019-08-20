require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  context 'show method' do
    it 'assign comment' do
      chef = create(:chef)
      recipe = chef.recipes.create(attributes_for(:recipe))

      get :show, params: {id: recipe.id}

      comment = Comment.new
      expect(assigns(:comment).id).to eq(comment.id)
    end
  end
end
