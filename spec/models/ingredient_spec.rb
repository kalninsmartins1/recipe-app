require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  context 'validation tests' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(25) }
    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  context 'association tests' do
    it { is_expected.to have_many(:recipes) }
  end
end
