require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'validation tests' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(20) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(500) }
  end

  context 'association tests' do
    it { is_expected.to belong_to(:chef) }
    it { is_expected.to have_many(:ingredients) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end
