require 'rails_helper'

RSpec.describe 'ChefsIndexController', type: :request do
  before(:each) do
    @chef1 = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
    @chef1.recipes.create(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    @chef1.recipes.create(name: 'Variti burkani',
                          description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')

    @chef2 = Chef.create(name: 'Jānis', email: 'janis12@awesome.com', password: 'parole2', password_confirmation: 'parole2')
    @chef2.recipes.create(name: 'Zirnu savtejus', description: 'Savte zirnus ar nedaudz elas, pec tam ed ar krejumu.')
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
      assert_select('a[href=?]', chef_path(@chef1), text: @chef1.name)
    end

    it 'should display chef2 name as hyperlink' do
      get chefs_path
      assert_select('a[href=?]', chef_path(@chef2), text: @chef2.name)
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
