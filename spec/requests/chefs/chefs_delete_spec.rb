require 'rails_helper'

RSpec.describe 'ChefsDelete', type: :request do
  let!(:admin_chef) { Chef.create!(name: 'Joe', email: 'joe123@test.com', password: 'password', admin: true) }

  def request_delete_chef(chef_to_delete)
    login(admin_chef.email, admin_chef.password)
    delete chef_path(chef_to_delete)
  end

  context 'successful chef delete' do
    let!(:chef) { Chef.create!(name: 'Jim', email: 'jim123@test.com', password: 'password') }

    it 'chefs count goes down by 1' do
      expect { request_delete_chef(chef) }.to change { Chef.count }.by(-1)
    end

    it 'redirects to chef index' do
      request_delete_chef(chef)
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it 'flash message is not empty' do
      request_delete_chef(chef)
      follow_redirect!
      expect(flash.empty?).to eq(false)
    end
  end

  context 'unsuccessful chef delete' do
    it 'return status code 402' do
      request_delete_chef(NullChefRecord.new)
    end
  end
end
