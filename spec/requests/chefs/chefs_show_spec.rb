require 'rails_helper'

RSpec.describe 'ChefsShow', type: :request do
  let(:chef) { Chef.create!(name: 'Peter', email: 'peter12@awesome.com', password: 'parole') }
  let!(:recipe_a) { chef.recipes.create!(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao') }
  let!(:recipe_b) do
    chef.recipes.create!(name: 'Variti burkani',
                         description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')
  end

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
