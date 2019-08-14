require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before(:each) do
    @ingredient = Ingredient.create(name: 'Coconut')
  end

  it 'has many recipes' do
    chef = Chef.create(name: 'Janis', email: 'janis31@lidotaji.com', password: 'parole')
    recipe1 = chef.recipes.create(name: 'Cepts calis', description: 'Vesals calis tiek cepts 1 stundu un 30 minutes cepes krasni.')
    recipe2 = chef.recipes.create(name: 'Kartupelu biesputra',
                                  description: 'Varam kartupelus ar nedaudz udens maisot, kamer izveidojas bieza masa.')

    recipe1.ingredients << @ingredient
    recipe2.ingredients << @ingredient

    expect(@ingredient.recipes.count).to eq(2)
  end

  context 'validation tests' do
    it 'name must be present' do
      @ingredient.name = ' '
      expect(@ingredient.valid?).to eq(false)
    end

    it 'name must be within 5..25' do
      @ingredient.name = 'a' * 3
      expect(@ingredient.valid?).to eq(false)

      @ingredient.name = 'a' * 26
      expect(@ingredient.valid?).to eq(false)

      @ingredient.name = 'a' * 15
      expect(@ingredient.valid?).to eq(true)
    end

    it 'name must be unique' do
      ingredient_other = Ingredient.create(name: @ingredient.name)
      expect(ingredient_other.valid?).to eq(false)

      ingredient_other.name = 'Jogurts'
      expect(ingredient_other.valid?).to eq(true)
    end
  end
end
