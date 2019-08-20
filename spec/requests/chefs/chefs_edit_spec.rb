require 'rails_helper'

RSpec.describe 'ChefsEdit', type: :request do
  let(:chef) { Chef.create!(name: 'Peter', email: 'peter12@awesome.com', password: 'parole') }
  let(:recipe_a) { chef.recipes.create!(name: 'Saldie kartupeli', description: 'Loti garsigi, ipasi ar cacao') }
  let(:recipe_b) do
    chef.recipes.create!(name: 'Variti burkani',
                         description: 'Varam 15 minutes katla kopa ar kiploku, tad pievienojam merci pec izveles')
  end
  before(:each) do
    login(chef.email, chef.password)
  end

  NEW_CHEF_NAME = 'Karlis'.freeze
  NEW_CHEF_EMAIL = 'karlisliepa@veiksme.com'.freeze

  def valid_chef_patch
    patch chef_path(chef), params: {chef: {name: NEW_CHEF_NAME, email: NEW_CHEF_EMAIL}}
  end

  it 'has edit route' do
    get edit_chef_path(chef)
    expect(response).to have_http_status(200)
  end

  context 'reject invalid update' do
    def invalid_chef_patch
      patch chef_path(chef), params: {chef: {name: '', email: 'test@test.com'}}
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
      expect(response.body).to match(NEW_CHEF_NAME)
    end

    it 'email should be updated' do
      valid_chef_patch
      follow_redirect!
      expect(response.body).to match(NEW_CHEF_EMAIL)
    end
  end

  context 'admin user updating other users' do
    it 'valid update' do
      admin_chef = Chef.create!(name: 'Karlis', email: 'karlis12@varaviksne.com', password: 'parole', admin: true)
      login(admin_chef.email, admin_chef.password)
      valid_chef_patch
    end

    it 'invalid update' do
      other_chef = Chef.create!(name: 'Valdis', email: 'valdis21@zakusala.com', password: 'parole')
      login(other_chef.email, other_chef.password)
      valid_chef_patch
    end
  end
end
