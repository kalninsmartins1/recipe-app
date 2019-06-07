require 'rails_helper'

RSpec.describe Chef, type: :model do
  context 'validation tests' do
    before(:each) do
      @chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com')
    end

    context 'name' do
      it 'should be present' do
        @chef.name = ' '
        expect(@chef.valid?).to eq(false)
      end

      it 'should not be shorter than 3 characters' do
        @chef.name = 'aa'
        expect(@chef.valid?).to eq(false)
      end

      it 'should not be longer than 20 characters' do
        @chef.name = 'a' * 21
        expect(@chef.valid?).to eq(false)
      end
    end

    context 'email' do
      it 'should be present' do
        @chef.email = ' '
        expect(@chef.valid?).to eq(false)
      end

      it 'shoud not be shorter than 3 characters' do
        @chef.email = 'a'
        expect(@chef.valid?).to eq(false)
      end

      it 'should not be longer than 320 characters' do
        @chef.email = 'a' * 321
        expect(@chef.valid?).to eq(false)
      end

      it 'should have correct format' do
        @chef.email = 'aaaa'
        expect(@chef.valid?).to eq(false)
      end

      it 'should be unique' do
        chef_dupe = @chef.dup
        @chef.save
        expect(chef_dupe.valid?).to eq(false)
      end

      it 'should be case insensitive' do
        chef_dupe = @chef.dup
        chef_dupe.email = @chef.email.upcase
        @chef.save
        expect(chef_dupe.valid?).to eq(false)
      end

      it 'should be lower case before hitting the database' do
        mixed_case_email = 'PeterisTestetajs@peteris.co.uk'
        @chef.email = mixed_case_email
        @chef.save
        expect(@chef.reload.email).to eq(mixed_case_email.downcase)
      end
    end
  end
end
