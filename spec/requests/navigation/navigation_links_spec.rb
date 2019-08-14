require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'NavigationLinks', type: :request do
  CHEAF_CHAT_LINK = 'href="/chat">Chefs chat</a>'.freeze

  context 'with login' do
    before(:each) do
      chef = Chef.create(name: 'Peter', email: 'peter12@test.com', password: 'password')
      login(chef.email, chef.password)
    end

    it 'has link to chef chat' do
      get root_path
      expect(response.body).to match(CHEAF_CHAT_LINK)
    end
  end

  context 'without login' do
    it 'has no link to chef chat' do
      get root_path
      expect(response.body).to_not match(CHEAF_CHAT_LINK)
    end
  end
end
