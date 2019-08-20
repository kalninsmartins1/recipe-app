require 'rails_helper'

RSpec.describe 'RecipesDeleteController', type: :request do
  let(:chef) { create(:chef) }
  let!(:recipe) { chef.recipes.create!(attributes_for(:recipe)) }

  before(:each) do
    login(chef.email, chef.password)
  end

  it 'should have delete link' do
    get recipe_path(recipe)
    expect(response.body).to match("href=\"#{recipe_path(recipe)}\">Delete</a>")
  end

  context 'successfully deleting recipe' do
    def request_recipe_delete
      delete recipe_path(recipe)
    end

    it 'recipe count in database is reduced' do
      expect { request_recipe_delete }.to change { Recipe.count }.by(-1)
    end

    it 'should redirect to index template' do
      request_recipe_delete
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it 'flash should not be empty' do
      request_recipe_delete
      expect(flash.empty?).to eq(false)
    end
  end

  context 'unsuccessfully deleting recipe' do
    it 'return status code 402' do
      chef.admin = true
      chef.save!
      recipe = Recipe.new(id: -1)
      delete recipe_path(recipe)
      expect(response).to have_http_status(402)
    end
  end
end
