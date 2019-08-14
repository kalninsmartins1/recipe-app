require 'rails_helper'

RSpec.describe 'ChefsLogin', type: :request do
  it 'has login path' do
    get login_path
  end

  context 'invalid login' do
    before(:each) do
      post login_path, params: {session: {email: ' ', password: 'do'}}
    end

    it 'stays on new template' do
      expect(response).to render_template(:new)
    end

    it 'flash is not empty' do
      expect(flash.empty?).to eq(false)
    end

    it 'flash is not appearing on next page' do
      get root_path
      expect(flash.empty?).to eq(true)
    end

    it 'has login link' do
      expect(response.body).to match('href="/login"')
    end
  end

  context 'valid login' do
    before(:each) do
      chef = Chef.create!(name: 'Alberts', email: 'korektsepasts@korekts.com', password: 'parole')
      login(chef.email, chef.password)
    end

    it 'redirects to show template' do
      follow_redirect!
      expect(response).to render_template(:show)
    end

    it 'flash has a message' do
      expect(flash.empty?).to eq(false)
    end

    it 'session hash has chef_id' do
      expect(session[:chef_id].blank?).to eq(false)
    end

    it 'has log out link' do
      follow_redirect!
      expect(response.body).to match('href="/login">Logout</a>')
    end

    it 'has view profile link' do
      follow_redirect!
      expect(response.body).to match('href="/chefs/1">View profile')
    end

    it 'has edit profile link' do
      follow_redirect!
      expect(response.body).to match('href="/chefs/1/edit">Edit profile')
    end
  end

  context 'logout' do
    before(:each) do
      delete login_path
    end

    it 'redirects to root path' do
      follow_redirect!
      expect(response).to render_template(:home)
    end

    it 'flash is not empty' do
      expect(flash.empty?).to eq(false)
    end

    it 'session hash does not contain chef id' do
      expect(session[:chef_id].blank?).to eq(true)
    end
  end
end
