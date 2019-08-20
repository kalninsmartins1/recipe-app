FactoryBot.define do
  factory :ingredient, class: Ingredient do
    name { 'Carrot' }
  end

  factory :ingredient_a, class: Ingredient do
    name { 'Sweet potato' }
  end

  factory :ingredient_b, class: Ingredient do
    name { 'Coconut oil' }
  end
end
