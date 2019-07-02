require 'rails_helper'

RSpec.describe 'ChefsShowController', type: :request do
  context 'view chef' do
    before(:each) do
      @chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
      @recipe1 = @chef.recipes.new(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
      @recipe2 = @chef.recipes.new(name: 'Variti burkani',
                                   description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')

      @recipe1.save!
      @recipe2.save!
    end

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
end
