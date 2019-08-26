require 'rails_helper'

RSpec.describe 'IngredientsControllerIndexAction', type: :request do
  let!(:first_ingredient) { create(:ingredient) }
  let!(:second_ingredient) { create(:ingredient) }

  it 'displays a list of ingredients' do
    get ingredients_path
    expect(response.body).to match(first_ingredient.name)
    expect(response.body).to match(second_ingredient.name)
  end

  it 'admin has a link to edit ingredient' do
    admin_chef = create(:admin_chef)
    login(admin_chef.email, admin_chef.password)

    get ingredients_path
    expect(response.body).to match(edit_ingredient_path(first_ingredient))
    expect(response.body).to match(edit_ingredient_path(second_ingredient))
  end
end
