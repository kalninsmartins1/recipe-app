require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'ChatroomsShowRequest', type: :request do
  before(:each) do
    chef = Chef.create(name: 'Peter', email: 'peter12@test.lv', password: 'password')
    @meesage1 = chef.messages.create(content: 'Splendid !')
    @message2 = chef.messages.create(content: 'Awesome !')
  end

  it 'displays many messages' do
    get chat_path
    expect(response.body).to match(@meesage1.content)
    expect(response.body).to match(@message2.content)
  end
end
