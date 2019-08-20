require 'rails_helper'

RSpec.describe 'IngredientsControllerCreateNewActions', type: :request do
  def post_valid_ingrdient_creation
    post ingredients_path(params: {ingredient: {name: 'Cheese'}})
  end

  def post_invalid_ingredient_creation
    post ingredients_path(params: {ingredient: {name: ''}})
  end

  context 'non admin actions' do
    it 'sites header does not have ingredient path' do
      get new_ingredient_path
      expect(response.body).not_to match(new_ingredient_path)
    end

    it 'reject valid ingredient creation' do
      post_valid_ingrdient_creation
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it 'rejects invalid ingredient creation' do
      post_invalid_ingredient_creation
      follow_redirect!
      expect(response).to render_template(:index) # Stays on new template
    end
  end

  context 'admin actions' do
    before(:each) do
      chef = Chef.create!(name: 'Peter', email: 'peter321@test.com', password: 'password', admin: true)
      login(chef.email, chef.password)
    end

    it 'sites header has new ingredient path' do
      get new_ingredient_path
      expect(response.body).to match(new_ingredient_path)
    end

    it 'accepts valid ingredient creation' do
      post_valid_ingrdient_creation
      follow_redirect!
      expect(response).to render_template(:show)
      expect(flash[:success].empty?).to eq(false)
    end

    it 'reject invalid ingreedient creation' do
      post_invalid_ingredient_creation
      expect(response).to render_template(:new)
    end
  end
end
