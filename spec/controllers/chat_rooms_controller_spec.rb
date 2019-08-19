require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do
  context 'show method' do
    before(:each) do
      chef = Chef.create(name: 'Peter', email: 'peter12@test.com', password: 'password')
      silent_login(chef.id)
      message = chef.messages.create(content: 'Nice content !')
      get :show, params: {id: message.id}
    end

    it 'assings messages' do
      expect(assigns(:messages).count).to eq(Message.count)
    end

    it 'assings message' do
      expect(assigns(:message).id).to eq(Message.new.id)
    end
  end
end