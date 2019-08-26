FactoryBot.define do
  factory :ingredient, class: Ingredient do
    sequence(:name) { |n| "ingredient#{n}" }
  end
end
