require 'rails_helper'

RSpec.describe 'RecipesDeleteController', type: :request do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
    @recipe = @chef.recipes.new(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    @recipe.save!
  end

  it 'should have delete link' do
    get recipe_path(@recipe)
    expect(response.body).to match("href=\"#{recipe_path(@recipe)}\">Delete</a>")
  end

  context 'successfully deleting recipe' do
    def request_recipe_delete
      delete recipe_path(@recipe)
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
end
