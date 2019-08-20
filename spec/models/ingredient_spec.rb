require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let!(:ingredient) { create(:ingredient) }

  it 'has many recipes' do
    chef = create(:chef)
    recipe_a = chef.recipes.create(attributes_for(:recipe_a))
    recipe_b = chef.recipes.create(attributes_for(:recipe_b))

    recipe_a.ingredients << ingredient
    recipe_b.ingredients << ingredient

    expect(ingredient.recipes.count).to eq(2)
  end

  context 'validation tests' do
    it 'name must be present' do
      ingredient.name = ' '
      expect(ingredient.valid?).to eq(false)
    end

    it 'name must be within 5..25' do
      ingredient.name = 'a' * 3
      expect(ingredient.valid?).to eq(false)

      ingredient.name = 'a' * 26
      expect(ingredient.valid?).to eq(false)

      ingredient.name = 'a' * 15
      expect(ingredient.valid?).to eq(true)
    end

    it 'name must be unique' do
      ingredient_other = build(:ingredient)
      expect(ingredient_other.valid?).to eq(false)

      ingredient_other.name = 'Jogurts'
      expect(ingredient_other.valid?).to eq(true)
    end
  end
end
