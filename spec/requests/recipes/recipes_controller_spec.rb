require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'RecipesController', type: :request do
  let(:chef) { create(:chef) }
  let!(:recipe_a) { chef.recipes.create!(attributes_for(:recipe_a)) }
  let!(:recipe_b) { chef.recipes.create!(attributes_for(:recipe_b)) }

  context 'GET /recipes' do
    before(:each) do
      create(:comment_a, recipe_id: recipe_a.id, chef_id: chef.id)
      create(:comment_b, recipe_id: recipe_a.id, chef_id: chef.id)
      get recipes_path
    end

    it 'should display number of comments' do
      expect(response.body).to match('2 Comments')
    end

    it 'the index route should exist' do
      expect(response).to have_http_status(200)
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end

    it 'should display recipe1 name as hyperlink' do
      assert_select('a[href=?]', recipe_path(recipe_a), text: recipe_a.name)
    end

    it 'should display recipe2 name as hyperlink' do
      assert_select('a[href=?]', recipe_path(recipe_b), text: recipe_b.name)
    end
  end

  context 'GET /recipes/:id' do
    it 'show recipe route should exist' do
      get recipe_path(recipe_a)
      expect(response).to have_http_status(200)
    end

    it 'should render show template' do
      get recipe_path(recipe_a)
      expect(response).to render_template(:show)
    end

    it 'should display recipe name' do
      get recipe_path(recipe_a)
      expect(response.body).to match(recipe_a.name)
    end

    it 'should display recipe description' do
      get recipe_path(recipe_b)
      expect(response.body).to match(recipe_b.description)
    end

    it 'shoul display chef name' do
      get recipe_path(recipe_a)
      expect(response.body).to match(chef.name)
    end

    it 'should have a link to recipe index' do
      get recipe_path(recipe_a)
      expect(response.body).to match("href=\"#{recipes_path}\">Show all recipes</a>")
    end

    it 'should display comments' do
      comment = create(:comment, chef_id: chef.id, recipe_id: recipe_a.id)
      get recipe_path(recipe_a)
      expect(response.body).to match(comment.description)
    end
  end

  context 'GET /recipes/new' do
    before(:each) do
      login(chef.email, chef.password)
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
        login(chef.email, chef.password)
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
      let(:new_recipe) { build(:recipe) }

      before(:each) do
        # Before each example perform a login
        login(chef.email, chef.password)
      end

      def post_valid_recipe(ingredient_ids = [])
        post recipes_path, params: {recipe: {name: new_recipe.name,
                                             description: new_recipe.description,
                                             ingredient_ids: ingredient_ids}}
      end

      it 'should display recipe name' do
        post_valid_recipe
        follow_redirect!
        expect(response.body).to match(new_recipe.name.capitalize)
      end

      it 'should display recipe description' do
        post_valid_recipe
        follow_redirect!
        expect(response.body).to match(new_recipe.description)
      end

      it 'should have ingredients' do
        ingredient = create(:ingredient)
        post_valid_recipe([ingredient.id])
        expect(ValidRecipeDecorator.find_by(name: new_recipe.name).ingredients.count).to_not eq(0)
      end
    end
  end
end
