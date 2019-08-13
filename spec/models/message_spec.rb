require 'rails_helper'

RSpec.describe Message, type: :model do
  before(:each) do
    chef = Chef.create(name: 'Peter', email: 'peter12@test.lv', password: 'password')
    @message = Message.new(content: 'This is a nice content !', chef_id: chef.id)
  end

  it 'chef_id cant be blank' do
    @message.chef_id = ''
    expect(@message.valid?).to eq(false)
  end

  it 'content must be present' do
    @message.content = ''
    expect(@message.valid?).to eq(false)
  end

  it 'content must not be longer than 200 characters' do
    @message.content = 'a' * 201
    expect(@message.valid?).to eq(false)
  end

  it 'content between 1 and 200 characters is valid' do
    @message.content = 'a' * 1
    expect(@message.valid?).to eq(true)

    @message.content = 'a' * 50
    expect(@message.valid?).to eq(true)

    @message.content = 'a' * 200
    expect(@message.valid?).to eq(true)
  end
end
