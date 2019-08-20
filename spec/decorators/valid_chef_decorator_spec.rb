require 'rails_helper'

RSpec.describe 'ValidChefDecorator' do
  let(:chef) { create(:chef) }

  context 'find method' do
    it 'should return NullChefRecord when no Chef has been found' do
      expect(ValidChefDecorator.find(-1)).to be_an_instance_of(NullChefRecord)
    end

    it 'shuld return valid chef when existing id provided' do
      expect(ValidChefDecorator.find(chef.id).name).to eq(chef.name)
    end
  end

  context 'find_by method' do
    it 'should return NullChefRecord when no Chef has been found' do
      expect(ValidChefDecorator.find_by(email: '')).to be_an_instance_of(NullChefRecord)
    end

    it 'should return valid chef when existing attribute is searched for' do
      expect(ValidChefDecorator.find_by(email: chef.email).name).to eq(chef.name)
    end
  end
end
