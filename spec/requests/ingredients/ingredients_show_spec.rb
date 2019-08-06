require 'rails_helper'

RSpec.describe 'IngredientsControllerShowAction', type: :request do
  before(:each) do
    @ingredient = Ingredient.create(name: 'Coconut')
    chef = Chef.create(name: 'John', email: 'john123@test.com', password: 'password')

    @first_recipe = Recipe.create(name: 'Coconut wonder', description: 'Tasty, tasty...', chef_id: chef.id)
    @second_recipe = Recipe.create(name: 'Coconut milk', description: 'Blend coconut with water.', chef_id: chef.id)
    [@first_recipe, @second_recipe].each do |recipe|
      recipe.ingredients << @ingredient
    end
  end

  it 'shows list of recipes' do
    get ingredient_path(@ingredient)
    expect(response.body).to match(@first_recipe.name)
    expect(response.body).to match(@second_recipe.name)
  end

  it 'recipes should have a link back to ingredient' do
    get ingredient_path(@ingredient)
    expect(response.body).to match(ingredient_path(@ingredient))
  end
end
