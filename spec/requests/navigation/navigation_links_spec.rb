require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'NavigationLinks', type: :request do
  context 'with login' do
    before(:each) do
      chef = Chef.create(name: 'Peter', email: 'peter12@test.com', password: 'password')
      login(chef.email, chef.password)
    end

    it 'has link to chef chat' do
      get root_path
      expect(response.body).to match('href="/chat">Chefs chat</a>')
    end
  end
end
