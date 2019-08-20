require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'ChatRoomsShowRequest', type: :request do
  let(:chef) { Chef.create!(name: 'Peter', email: 'peter12@test.com', password: 'password') }
  let!(:message_a) { chef.messages.create!(content: 'Splendid !') }
  let!(:message_b) { chef.messages.create!(content: 'Awesome !') }

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
