require 'rails_helper'

RSpec.describe 'ChefsEdit', type: :request do
  let(:chef) { create(:chef) }
  let(:recipe) { chef.recipes.create!(attributes_for(:recipe)) }
  let(:recipe) { chef.recipes.create!(attributes_for(:recipe)) }
  let(:new_chef) { build(:chef) }

  before(:each) do
    login(chef.email, chef.password)
  end

  def valid_chef_patch
    patch chef_path(chef), params: {chef: {name: new_chef.name, email: new_chef.email}}
  end

  it 'has edit route' do
    get edit_chef_path(chef)
    expect(response).to have_http_status(200)
  end

  context 'reject invalid update' do
    def invalid_chef_patch
      patch chef_path(chef), params: {chef: {name: '', email: new_chef.email}}
    end

    it 'is not redirected away from edit template' do
      invalid_chef_patch
      expect(response).to render_template(:edit)
    end

    it 'error message is displayed' do
      invalid_chef_patch
      expect(response.body).to match('<h2 class="card-title">')
      expect(response.body).to match('<div class="card-body">')
    end
  end

  context 'accept valid update' do
    it 'redirects to show template' do
      valid_chef_patch
      follow_redirect!
      expect(response).to render_template(:show)
    end

    it 'flash is not empty' do
      valid_chef_patch
      follow_redirect!
      expect(flash.empty?).to eq(false)
    end

    it 'name should be updated' do
      valid_chef_patch
      follow_redirect!
      expect(response.body).to match(new_chef.name)
    end

    it 'email should be updated' do
      valid_chef_patch
      follow_redirect!
      expect(response.body).to match(new_chef.email.downcase)
    end
  end

  context 'admin user updating other users' do
    it 'valid update' do
      admin_chef = create(:admin_chef)
      login(admin_chef.email, admin_chef.password)
      valid_chef_patch
    end

    it 'invalid update' do
      other_chef = create(:chef)
      login(other_chef.email, other_chef.password)
      valid_chef_patch
    end
  end
end
