require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'ChatRoomsShowRequest', type: :request do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@test.com', password: 'password')
    @message_a = @chef.messages.create(content: 'Splendid !')
    @message_b = @chef.messages.create(content: 'Awesome !')
  end

  it 'displays many messages' do
    login(@chef.email, @chef.password)
    get chat_path
    expect(response.body).to match(@message_a.content)
    expect(response.body).to match(@message_b.content)
  end

  it 'unauthorized chefs cant access chat room' do
    get chat_path
    expect(response).to redirect_to(root_path)
  end
end
