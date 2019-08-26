require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  context 'association tests' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:ingredient) }
  end
end
