require 'rails_helper'

RSpec.describe 'ChefsController', type: :request do
  context 'signup' do
    it 'route exists' do
      get signup_path
      expect(response).to have_http_status(200)
    end

    context 'invalid submission' do
      def post_invalid_chef
        post chefs_path, params: {chef: {name: '', email: '', password: 'pass', password_confirmation: 'pass'}}
      end

      it 'no difference in database chef count' do
        expect { post_invalid_chef }.to change { Chef.count }.by(0)
      end

      it 'is still on new template' do
        post_invalid_chef
        expect(response).to render_template(:new)
      end

      it 'rendering error messages' do
        post_invalid_chef
        expect(response.body).to match('<h2 class="card-title">')
        expect(response.body).to match('<div class="card-body">')
      end
    end

    context 'valid submission' do
      CHEF_JOHN_EMAIL = 'john123@test.com'.freeze
      def post_valid_chef
        post chefs_path, params: {chef: {name: 'John', email: CHEF_JOHN_EMAIL,
                                         password: 'password'}}
      end

      it 'count in database has increased' do
        expect { post_valid_chef }.to change { Chef.count }.by(1)
      end

      it 'redirected to show template' do
        post_valid_chef
        follow_redirect!
        expect(response).to render_template(:show)
      end

      it 'flash messages are not empty' do
        post_valid_chef
        expect(flash.empty?).to eq(false)
      end

      it 'created chef is logged in' do
        post_valid_chef
        chef = Chef.find_by(email: CHEF_JOHN_EMAIL)
        expect(session[:chef_id]).to eq(chef.id)
      end
    end
  end
end
