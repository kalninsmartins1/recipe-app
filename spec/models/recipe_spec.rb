require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'validation tests' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(20) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(5).is_at_most(500) }
  end

  context 'association tests' do
    it { should belong_to(:chef) }
    it { should have_many(:ingredients) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
