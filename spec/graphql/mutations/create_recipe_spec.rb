require 'rails_helper'

RSpec.describe 'CreateRecipe' do
  let(:chef) { Chef.create(name: 'Josh', email: 'joshwelch@test.com', password: 'password') }
  let(:test_name) { 'Coconut' }
  let(:test_description) { 'Break the shell.' }

  def perform(**args)
    Mutations::CreateRecipe.new(object: nil, context: {}).resolve(args)
  end

  context 'invalid chef mutation' do
    it 'chef_id is required' do
      result = perform(name: test_name, description: test_description)
      expect(result).to be_kind_of(GraphQL::ExecutionError)
    end

    it 'name is required' do
      result = perform(description: test_description, chef_id: chef.id)
      expect(result).to be_kind_of(GraphQL::ExecutionError)
    end

    it 'description is required' do
      result = perform(name: test_name, chef_id: chef.id)
      expect(result).to be_a_kind_of(GraphQL::ExecutionError)
    end
  end

  context 'valid chef mutation' do
    let(:created_recipe) { perform(name: test_name, description: test_description, chef_id: chef.id) }

    it 'created recipe is persisted' do
      expect(created_recipe.persisted?).to eq(true)
    end

    it 'created recipe has correct name' do
      expect(created_recipe.name).to eq(test_name)
    end

    it 'created recipe has correct description' do
      expect(created_recipe.description).to eq(test_description)
    end

    it 'created recipe has correct chef id' do
      expect(created_recipe.chef_id).to eq(chef.id)
    end
  end
end
