FactoryBot.define do
  factory :recipe, class: Recipe do
    sequence(:name) { |n| "Recipe name #{n}" }
    sequence(:description) { |n| "This is description #{n}" }
  end
end
