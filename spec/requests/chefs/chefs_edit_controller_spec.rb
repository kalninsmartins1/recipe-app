require 'rails_helper'

RSpec.describe 'ChefEditController', type: :request do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
    @recipe1 = @chef.recipes.new(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao')
    @recipe2 = @chef.recipes.new(name: 'Variti burkani',
                                 description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')

    @recipe1.save!
    @recipe2.save!
    login(@chef.email, @chef.password)
  end

  it 'has edit route' do
    get edit_chef_path(@chef)
    expect(response).to have_http_status(200)
  end

  context 'reject invalid update' do
    def invalid_chef_patch
      patch chef_path(@chef), params: {chef: {name: '', email: 'test@test.lv'}}
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
    NEW_CHEF_NAME = 'Karlis'.freeze
    NEW_CHEF_EMAIL = 'karlisliepa@veiksme.lv'.freeze

    before(:each) do
      patch chef_path(@chef), params: {chef: {name: NEW_CHEF_NAME, email: NEW_CHEF_EMAIL}}
      follow_redirect!
    end

    it 'redirects to show template' do
      expect(response).to render_template(:show)
    end

    it 'flash is not empty' do
      expect(flash.empty?).to eq(false)
    end

    it 'name should be updated' do
      expect(response.body).to match(NEW_CHEF_NAME)
    end

    it 'email should be updated' do
      expect(response.body).to match(NEW_CHEF_EMAIL)
    end
  end
end
