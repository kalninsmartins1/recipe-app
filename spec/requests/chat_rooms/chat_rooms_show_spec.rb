require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'ChatRoomsShowRequest', type: :request do
  let(:chef) { create(:chef) }
  let!(:message_a) { chef.messages.create!(attributes_for(:message_a)) }
  let!(:message_b) { chef.messages.create!(attributes_for(:message_b)) }

  it 'displays many messages' do
    login(chef.email, chef.password)
    get chat_path
    expect(response.body).to match(message_a.content)
    expect(response.body).to match(message_b.content)
  end

  it 'unauthorized chefs cant access chat room' do
    get chat_path
    expect(response).to redirect_to(root_path)
  end
end
