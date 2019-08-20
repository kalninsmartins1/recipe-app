require 'rails_helper'

RSpec.describe 'ChefsListing', type: :request do
  let(:chef_a) { Chef.create!(name: 'Peter', email: 'peter12@awesome.com', password: 'passwords') }
  let(:chef_b) { Chef.create!(name: 'Jānis', email: 'janis12@awesome.com', password: 'parole2') }

  before(:each) do
    chef_a.recipes.create!(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    chef_a.recipes.create!(name: 'Variti burkani',
                           description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')
    chef_b.recipes.create!(name: 'Zirnu savtejus', description: 'Savte zirnus ar nedaudz elas, pec tam ed ar krejumu.')
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
