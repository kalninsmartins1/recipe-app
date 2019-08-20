require 'rails_helper'

RSpec.describe 'ChefsShow', type: :request do
  let(:chef) { create(:chef) }
  let!(:recipe_a) { chef.recipes.create!(attributes_for(:recipe_a)) }
  let!(:recipe_b) { chef.recipes.create!(attributes_for(:recipe_b)) }

  it 'all the links to recipes are present' do
    get chef_path(chef)
    expect(response.body).to match("href=\"#{recipe_path(recipe_a)}\"")
    expect(response.body).to match("href=\"#{recipe_path(recipe_b)}\"")
  end

  it 'all recipe descriptions are present' do
    get chef_path(chef)
    expect(response.body).to match(recipe_a.description)
    expect(response.body).to match(recipe_b.description)
  end

  it 'chefs name should be preset' do
    get chef_path(chef)
    expect(response.body).to match(chef.name)
  end
end
