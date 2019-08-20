require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do
  context 'show method' do
    let(:chef) { create(:chef) }
    before(:each) do
      silent_login(chef.id)
      message = chef.messages.create!(attributes_for(:message))
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
