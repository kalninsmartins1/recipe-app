require 'rails_helper'

RSpec.describe 'IngredientsControllerIndexAction', type: :request do
  before(:each) do
    @first_ingredient = Ingredient.create(name: 'Coconut')
    @second_ingredient = Ingredient.create(name: 'Pumpkin')
  end

  it 'displays a list of ingredients' do
    get ingredients_path
    expect(response.body).to match(@first_ingredient.name)
    expect(response.body).to match(@second_ingredient.name)
  end

  it 'admin has a link to edit ingredient' do
    chef = Chef.create(name: 'Admin', email: 'admin@test.com', password: 'password', admin: true)
    login(chef.email, chef.password)
    get ingredients_path
    expect(response.body).to match(edit_ingredient_path(@first_ingredient))
    expect(response.body).to match(edit_ingredient_path(@second_ingredient))
  end
end
