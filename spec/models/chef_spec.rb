require 'rails_helper'

RSpec.describe Chef, type: :model do
  let(:chef) { create(:chef) }

  it { is_expected.to have_secure_password }

  context 'validation tests' do
    context 'name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(20) }
    end

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_least(3).is_at_most(320) }
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

      it 'should have correct format' do
        chef.email = 'aaaa'
        expect(chef.valid?).to eq(false)
      end

      it 'should be lower case after saving' do
        mixed_case_email = 'PeterisTestetajs@peteris.co.uk'
        chef.email = mixed_case_email
        chef.save
        expect(chef.reload.email).to eq(mixed_case_email.downcase)
      end
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(5) }
    end
  end

  context 'association tests' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:recipes).dependent(:destroy) }
    it { is_expected.to have_many(:messages).dependent(:destroy) }
  end
end
