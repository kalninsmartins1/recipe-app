require 'rails_helper'

RSpec.describe 'RecipesController', type: :request do
  describe 'GET /recipes' do
    before(:each) do
      @chef = Chef.create!(name: 'Peter', email: 'peter12@awesome.com')
      @recipe1 = @chef.recipes.build(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
      @recipe2 = @chef.recipes.build(name: 'Variti burkani',
                                     description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')

      @recipe1.save!
      @recipe2.save!
    end

    it 'the index route should exist' do
      get recipes_path
      expect(response).to have_http_status(200)
    end

    it 'should render index template' do
      get recipes_path
      expect(response).to render_template(:index)
    end

    it 'should display recipe1' do
      get recipes_path
      expect(response.body).to match(@recipe1.name)
    end

    it 'should display recipe2' do
      get recipes_path
      expect(response.body).to match(@recipe2.name)
    end
  end
end
