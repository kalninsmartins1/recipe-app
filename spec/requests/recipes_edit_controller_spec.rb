require 'rails_helper'

RSpec.describe 'RecipesEditController', type: :request do
  before(:each) do
    @chef = Chef.create!(name: 'Peter', email: 'peter12@awesome.com')
    @recipe = @chef.recipes.new(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    @recipe.save!
  end

  it 'should have edit template' do
    get edit_recipe_path(@recipe)
    expect(response).to render_template(:edit)
  end

  context 'invalid recipe update' do
    def invalid_recipe_patch
      patch recipe_path(@recipe), params: {recipe: {name: '', description: 'this is description'}}
    end

    before(:each) do
      invalid_recipe_patch
    end

    it 'after submission should render edit template' do
      expect(response).to render_template(:edit)
    end

    it 'should have <h2 class="card-title"> field' do
      expect(response.body).to match('<h2 class="card-title">')
    end

    it 'should have <div class="card-body"> field' do
      expect(response.body).to match('<div class="card-body">')
    end
  end

  context 'valid recipe update' do
    NAME = 'sweet potatoe'.freeze
    DESCRIPTION = 'Boil, prepare dip, enjoy !'.freeze

    def valid_recipe_patch
      patch recipe_path(@recipe), params: {recipe: {name: NAME, description: DESCRIPTION}}
    end

    before(:each) do
      valid_recipe_patch
      follow_redirect!
    end

    it 'should redirect to show page' do
      expect(response).to render_template(:show)
    end

    it 'should have non empty flash hash' do
      expect(flash.empty?).to eq(false)
    end

    it 'should display recipe name' do
      expect(response.body).to match(NAME.capitalize)
    end

    it 'should display recipe description' do
      puts response.body
      expect(response.body).to match(DESCRIPTION)
    end
  end
end
