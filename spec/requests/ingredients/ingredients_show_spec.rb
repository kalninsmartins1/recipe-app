require 'rails_helper'

RSpec.describe 'IngredientsControllerShowAction', type: :request do
  let(:chef) { Chef.create!(name: 'John', email: 'john123@test.com', password: 'password') }
  let(:first_recipe) { chef.recipes.create(name: 'Coconut wonder', description: 'Tasty, tasty...') }
  let(:second_recipe) { chef.recipes.create(name: 'Coconut milk', description: 'Blend coconut with water.') }
  let(:ingredient) { Ingredient.create!(name: 'Coconut') }

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
