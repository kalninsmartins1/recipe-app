require 'rails_helper'

RSpec.describe 'IngredientsControllerShowAction', type: :request do
  let(:chef) { create(:chef) }
  let(:first_recipe) { chef.recipes.create!(attributes_for(:recipe_a)) }
  let(:second_recipe) { chef.recipes.create!(attributes_for(:recipe_b)) }
  let(:ingredient) { create(:ingredient) }

  before(:each) do
    [first_recipe, second_recipe].each do |recipe|
      recipe.ingredients << ingredient
    end
  end

  it 'shows list of recipes' do
    get ingredient_path(ingredient)
    expect(response.body).to match(first_recipe.name)
    expect(response.body).to match(second_recipe.name)
  end

  it 'recipes should have a link back to ingredient' do
    get ingredient_path(ingredient)
    expect(response.body).to match(ingredient_path(ingredient))
  end
end
