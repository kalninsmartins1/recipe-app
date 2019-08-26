require 'rails_helper'

RSpec.describe 'ChefsListing', type: :request do
  let(:chef_a) { create(:chef) }
  let(:chef_b) { create(:chef) }

  before(:each) do
    chef_a.recipes.create!(attributes_for(:recipe))
    chef_a.recipes.create!(attributes_for(:recipe))
    chef_b.recipes.create!(attributes_for(:recipe))
  end

  context 'has index route' do
    it 'the index route should exist' do
      get chefs_path
      expect(response).to have_http_status(200)
    end

    it 'should render index template' do
      get chefs_path
      expect(response).to render_template(:index)
    end

    it 'should display chef1 name as hyperlink' do
      get chefs_path
      assert_select('a[href=?]', chef_path(chef_a), text: chef_a.name)
    end

    it 'should display chef2 name as hyperlink' do
      get chefs_path
      assert_select('a[href=?]', chef_path(chef_b), text: chef_b.name)
    end

    it 'should display correct recipe count for chef1' do
      get chefs_path
      expect(response.body).to match('2 recipes')
    end

    it 'should display correct recipe count for chef2' do
      get chefs_path
      expect(response.body).to match('1 recipe')
    end
  end
end
