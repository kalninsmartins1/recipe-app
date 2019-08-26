require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'validation tests' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_least(1).is_at_most(200) }
  end

  context 'association tests' do
    it { is_expected.to belong_to(:chef) }
  end
end
