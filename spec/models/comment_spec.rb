require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validation tests' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(4).is_at_most(140) }
  end

  context 'association tests' do
    it { should belong_to(:chef) }
    it { should belong_to(:recipe) }
  end
end
