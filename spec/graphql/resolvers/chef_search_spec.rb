require 'rails_helper'

RSpec.describe 'CreateSearch' do
  let(:chef_a) { Chef.create(name: 'Josh', email: 'joshwader@test.com', password: 'password') }
  let(:chef_b) { Chef.create(name: 'Will', email: 'willbuckly@test.com', password: 'password') }

  def find(args)
    Resolvers::ChefsSearch.call(nil, args, nil)
  end

  it 'chef "a" can be found by name' do
    result = find(filter: {name_contains: chef_a.name})
    expect(result.one?).to eq(true)
    expect(result.first.name).to eq(chef_a.name)
  end

  it 'chef "b" can be found by name' do
    result = find(filter: {name_contains: chef_b.name})
    expect(result.one?).to eq(true)
    expect(result.first.name).to eq(chef_b.name)
  end

  it 'chef "a" can be found by email' do
    result = find(filter: {email_contains: chef_a.email})
    expect(result.one?).to eq(true)
    expect(result.first.email).to eq(chef_a.email)
  end

  it 'chef "b" can be found by email' do
    result = find(filter: {email_contains: chef_b.email})
    expect(result.one?).to eq(true)
    expect(result.first.email).to eq(chef_b.email)
  end

  it 'filtering with OR returns both chefs' do
    result = find(filter: {OR: [{name_contains: chef_a.name, email_contains: chef_b.email}]})
    expect(result.many?).to eq(true)
    expect(result.find { |chef| chef.name == chef_a.name }).to_not be(nil)
    expect(result.find { |chef| chef.email == chef_b.email }).to_not be(nil)
  end
end
