require 'rails_helper'

RSpec.describe 'ChefsShowController', type: :request do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
    @recipe1 = @chef.recipes.new(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    @recipe2 = @chef.recipes.new(name: 'Variti burkani',
                                 description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')

    @recipe1.save!
    @recipe2.save!

    @admin_chef = Chef.create(name: 'Karlis', email: 'karlis12@ziepniekkalns.com', password: 'parole', admin: true)
  end

  context 'view chef' do
    it 'all the links to recipes are present' do
      get chef_path(@chef)
      expect(response.body).to match("href=\"#{recipe_path(@recipe1)}\"")
      expect(response.body).to match("href=\"#{recipe_path(@recipe2)}\"")
    end

    it 'all recipe descriptions are present' do
      get chef_path(@chef)
      expect(response.body).to match(@recipe1.description)
      expect(response.body).to match(@recipe2.description)
    end

    it 'chefs name should be preset' do
      get chef_path(@chef)
      expect(response.body).to match(@chef.name)
    end
  end

  context 'delete chef' do
    def request_delete_chef
      @chef.save!
      login(@admin_chef.email, @admin_chef.password)
      delete chef_path(@chef)
    end

    it 'chefs count goes down by 1' do
      expect { request_delete_chef }.to change { Chef.count }.by(-1)
    end

    it 'redirects to chef index' do
      request_delete_chef
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it 'flash message is not empty' do
      request_delete_chef
      follow_redirect!
      expect(flash.empty?).to eq(false)
    end
  end
end
