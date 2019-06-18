require 'rails_helper'

RSpec.describe 'RecipesController', type: :request do
  before(:each) do
    @chef = Chef.create!(name: 'Peter', email: 'peter12@awesome.com')
    @recipe1 = @chef.recipes.build(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    @recipe2 = @chef.recipes.build(name: 'Variti burkani',
                                   description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')

    @recipe1.save!
    @recipe2.save!
  end

  context 'GET /recipes' do
    it 'the index route should exist' do
      get recipes_path
      expect(response).to have_http_status(200)
    end

    it 'should render index template' do
      get recipes_path
      expect(response).to render_template(:index)
    end

    it 'should display recipe1 name as hyperlink' do
      get recipes_path
      assert_select('a[href=?]', recipe_path(@recipe1), text: @recipe1.name)
    end

    it 'should display recipe2 name as hyperlink' do
      get recipes_path
      assert_select('a[href=?]', recipe_path(@recipe2), text: @recipe2.name)
    end
  end

  context 'GET /recipes/:id' do
    it 'show recipe route should exist' do
      get recipe_path(@recipe1)
      expect(response).to have_http_status(200)
    end

    it 'should render show template' do
      get recipe_path(@recipe1)
      expect(response).to render_template(:show)
    end

    it 'should display recipe name' do
      get recipe_path(@recipe1)
      expect(response.body).to match(@recipe1.name)
    end

    it 'should display recipe description' do
      get recipe_path(@recipe2)
      expect(response.body).to match(@recipe2.description)
    end

    it 'shoul display chef name' do
      get recipe_path(@recipe1)
      expect(response.body).to match(@chef.name)
    end
  end

  context 'GET /recipes/new' do
    it 'new recipe route should exist' do
      get new_recipes_path
      expect(response).to have_http_status(200)
    end

    it 'should render new template' do
      get new_recipes_path
      expect(response).to render_template(:new)
    end
  end
end
