require 'rails_helper'

RSpec.describe 'RecipesEditController', type: :request do
  let(:chef) { create(:chef) }
  let(:recipe) { chef.recipes.create!(attributes_for(:recipe)) }
  let(:ingredient) { create(:ingredient) }

  before(:each) do
    login(chef.email, chef.password)
  end

  it 'should have edit template' do
    get edit_recipe_path(recipe)
    expect(response).to render_template(:edit)
  end

  context 'invalid recipe update' do
    def invalid_recipe_patch
      new_recipe = build(:recipe)
      patch recipe_path(recipe), params: {recipe: {name: '', description: new_recipe.description}}
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
    let(:new_recipe) { build(:recipe) }

    def valid_recipe_patch(ingredient_ids = [])
      patch recipe_path(recipe), params: {recipe: {name: new_recipe.name,
                                                   description: new_recipe.description,
                                                   ingredient_ids: ingredient_ids}}
    end

    it 'should redirect to show page' do
      valid_recipe_patch
      follow_redirect!
      expect(response).to render_template(:show)
    end

    it 'should have non empty flash hash' do
      valid_recipe_patch
      expect(flash.empty?).to eq(false)
    end

    it 'should have added new ingredient' do
      valid_recipe_patch([ingredient.id])
      expect(recipe.ingredients.count).to_not eq(0)
    end

    it 'should have removed an ingredient' do
      valid_recipe_patch([ingredient.id]) # Add ingredient
      valid_recipe_patch                  # Remove all ingredients
      expect(recipe.ingredients.count).to eq(0)
    end

    it 'should display recipe name' do
      valid_recipe_patch
      follow_redirect!
      expect(response.body).to match(new_recipe.name.capitalize)
    end

    it 'should display recipe description' do
      valid_recipe_patch
      follow_redirect!
      expect(response.body).to match(new_recipe.description)
    end

    it 'should have link to edit recipe' do
      valid_recipe_patch
      follow_redirect!
      expect(response.body).to match("href=\"#{edit_recipe_path(recipe)}\">Edit</a>")
    end
  end
end
