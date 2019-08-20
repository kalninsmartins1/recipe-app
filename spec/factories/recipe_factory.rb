FactoryBot.define do
  factory :recipe, class: Recipe do
    name { 'Baked sweet patatoe' }
    description { 'Cut sweet patotoes and put them in oven.' }
  end

  factory :recipe_a, class: Recipe do
    name { 'Steemed brocoli' }
    description { 'Cut brocoli, put them in put, with little bit of water.' }
  end

  factory :recipe_b, class: Recipe do
    name { 'Boiled carrots' }
    description { 'Cut carrots, put them in pot and boil for 20 min.' }
  end
end
