require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'MessagesCreate', type: :request do
  let(:new_message) { build(:message) }

  def post_message(message)
    post messages_path, params: {message: {content: message}}
  end

  context 'with login' do
    before(:each) do
      chef = create(:chef)
      login(chef.email, chef.password)
    end

    it 'invalid submission is rejected' do
      expect { post_message('') }.to change { Message.count }.by(0)
    end

    it 'valid submission is accepted' do
      expect { post_message(new_message.content) }.to change { Message.count }.by(1)
    end
  end

  context 'without login' do
    it 'valid submission is rejected' do
      expect { post_message(new_message.content) }.to change { Message.count }.by(0)
    end
  end
end
