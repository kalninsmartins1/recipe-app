require 'rails_helper'

RSpec.describe 'CreateChef' do
  def perform(**args)
    Mutations::CreateChef.new(object: nil, context: {}).resolve(args)
  end

  context 'invalid chef mutation' do
    it 'email is required' do
      result = perform(name: 'Josh', password: 'password')
      expect(result).to be_kind_of(GraphQL::ExecutionError)
    end

    it 'name is required' do
      result = perform(email: 'joshwader@test.com', password: 'password')
      expect(result).to be_kind_of(GraphQL::ExecutionError)
    end

    it 'password is required' do
      result = perform(name: 'Josh', email: 'joshwader@test.com')
      expect(result).to be_a_kind_of(GraphQL::ExecutionError)
    end
  end

  context 'valid chef mutation' do
    NAME = 'John'.freeze
    EMAIL = 'johntreec@test.com'.freeze

    before(:each) do
      @chef = perform(name: NAME, email: EMAIL, password: 'password')
    end

    it 'created chef is persisted' do
      expect(@chef.persisted?).to eq(true)
    end

    it 'created chef has correct name' do
      expect(@chef.name).to eq(NAME)
    end

    it 'created chef has correct email' do
      expect(@chef.email).to eq(EMAIL)
    end
  end
end
