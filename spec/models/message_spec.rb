require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:chef) { create(:chef) }
  let(:message) { build(:message, chef_id: chef.id) }

  it 'chef_id cant be blank' do
    message.chef_id = ''
    expect(message.valid?).to eq(false)
  end

  it 'content must be present' do
    message.content = ''
    expect(message.valid?).to eq(false)
  end

  it 'content must not be longer than 200 characters' do
    message.content = 'a' * 201
    expect(message.valid?).to eq(false)
  end

  it 'content between 1 and 200 characters is valid' do
    message.content = 'a' * 1
    expect(message.valid?).to eq(true)

    message.content = 'a' * 50
    expect(message.valid?).to eq(true)

    message.content = 'a' * 200
    expect(message.valid?).to eq(true)
  end
end
