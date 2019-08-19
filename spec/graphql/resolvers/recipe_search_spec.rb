require 'rails_helper'

RSpec.describe 'RecipesSearch' do
  let(:chef) { Chef.create!(name: 'Josh', email: 'joshwader@test.com', password: 'password') }
  let(:recipe_a) { chef.recipes.create!(name: 'Coconut', description: 'Use hammer to open.') }
  let(:recipe_b) { chef.recipes.create!(name: 'Carrot', description: 'Wash it, cut it.') }

  def find(args)
    Resolvers::RecipesSearch.call(nil, args, nil)
  end

  it 'recipe "a" can be found by name' do
    result = find(filter: {name_contains: recipe_a.name})
    expect(result.one?).to eq(true)
    expect(result.first.name).to eq(recipe_a.name)
  end

  it 'recipe "b" can be found by name' do
    result = find(filter: {name_contains: recipe_b.name})
    expect(result.one?).to eq(true)
    expect(result.first.name).to eq(recipe_b.name)
  end

  it 'recipe "a" can be found by description' do
    result = find(filter: {description_contains: recipe_a.description})
    expect(result.one?).to eq(true)
    expect(result.first.description).to eq(recipe_a.description)
  end

  it 'recipe "b" can be found by description' do
    result = find(filter: {description_contains: recipe_b.description})
    expect(result.one?).to eq(true)
    expect(result.first.description).to eq(recipe_b.description)
  end

  it 'recipes can be filtered by chef_id' do
    expect(recipe_a.chef_id).to eq(recipe_b.chef_id)

    result = find(filter: {chef_id: chef.id})

    expect(result.many?).to eq(true)
    expect(result.find { |recipe| recipe.id == recipe_a.id }).to_not be(nil)
    expect(result.find { |recipe| recipe.id == recipe_b.id }).to_not be(nil)
  end

  it 'filtering with "OR" returns both recipes' do
    result = find(filter: {OR: [{name_contains: recipe_a.name, description_contains: recipe_b.description}]})
    expect(result.many?).to eq(true)
    expect(result.find { |recipe| recipe.name == recipe_a.name }).to_not be(nil)
    expect(result.find { |recipe| recipe.description == recipe_b.description }).to_not be(nil)
  end
end
