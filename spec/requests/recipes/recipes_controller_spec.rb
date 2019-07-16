require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'RecipesController', type: :request do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
    @recipe1 = @chef.recipes.new(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    @recipe2 = @chef.recipes.new(name: 'Variti burkani',
                                 description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')

    @recipe1.save!
    @recipe2.save!
  end

  context 'GET /recipes' do
    before(:each) do
      get recipes_path
    end

    it 'the index route should exist' do
      expect(response).to have_http_status(200)
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end

    it 'should display recipe1 name as hyperlink' do
      assert_select('a[href=?]', recipe_path(@recipe1), text: @recipe1.name)
    end

    it 'should display recipe2 name as hyperlink' do
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

    it 'should have a link to recipe index' do
      get recipe_path(@recipe1)
      expect(response.body).to match("href=\"#{recipes_path}\">Show all recipes</a>")
    end
  end

  context 'GET /recipes/new' do
    before(:each) do
      login(@chef.email, @chef.password)
      get new_recipe_path
    end

    it 'new recipe route should exist' do
      expect(response).to have_http_status(200)
    end

    it 'should render new template' do
      expect(response).to render_template(:new)
    end
  end

  context 'POST /recipes' do
    context 'invalid submission' do
      before(:each) do
        login(@chef.email, @chef.password)
        # Before each example post an invalid recipe
        post recipes_path, params: {recipe: {name: '', description: ''}}
      end

      it 'should render new template' do
        expect(response).to render_template(:new)
      end

      it 'should have <h2 class="card-title"> field' do
        expect(response.body).to match('<h2 class="card-title">')
      end

      it 'should have <div class="card-body"> field' do
        expect(response.body).to match('<div class="card-body">')
      end
    end

    context 'valid submission' do
      RECIPE_NAME = 'saldie kartupeli'.freeze
      RECIPE_DESCRIPTION = 'jum jum... Tik japieliek klat kakao :P'.freeze

      before(:each) do
        # Before each example post a valid recipe
        login(@chef.email, @chef.password)
        post recipes_path, params: {recipe: {name: RECIPE_NAME, description: RECIPE_DESCRIPTION}}
        follow_redirect!
      end

      it 'should display recipe name' do
        expect(response.body).to match(RECIPE_NAME.capitalize)
      end

      it 'should display recipe description' do
        expect(response.body).to match(RECIPE_DESCRIPTION)
      end
    end
  end
end
