require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validation tests' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(4).is_at_most(140) }
  end

  context 'association tests' do
    it { is_expected.to belong_to(:chef) }
    it { is_expected.to belong_to(:recipe) }
  end
end
