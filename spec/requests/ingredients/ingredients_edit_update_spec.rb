require 'rails_helper'

RSpec.describe 'IngredientsControllerEditUpdateActions', type: :request do
  let(:ingredient) { create(:ingredient) }
  let(:new_ingredient) { build(:ingredient) }

  def patch_valid_ingredient_update
    patch ingredient_path(ingredient, params: {ingredient: {name: new_ingredient.name}})
  end

  def patch_invalid_ingredient_update
    patch ingredient_path(ingredient, params: {ingredient: {name: ''}})
  end

  context 'non admin actions' do
    it 'reject valid ingredient update' do
      patch_valid_ingredient_update
      follow_redirect!

      # Non admins should be redirected to index page
      expect(response).to render_template(:index)
    end

    it 'rejects invalid ingredient update' do
      patch_invalid_ingredient_update
      follow_redirect!

      expect(response).to render_template(:index) # Non admins are redirected to index
    end
  end

  context 'admin actions' do
    before(:each) do
      admin_chef = create(:admin_chef)
      login(admin_chef.email, admin_chef.password)
    end

    it 'accepts valid ingredient update' do
      patch_valid_ingredient_update
      follow_redirect!

      expect(flash[:success].empty?).to eq(false)
      expect(response).to render_template(:show)
    end

    it 'reject invalid ingredient update' do
      patch_invalid_ingredient_update
      expect(response).to render_template(:edit)
    end
  end
end
