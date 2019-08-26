FactoryBot.define do
  factory :comment, class: Comment do
    sequence(:description) { |n| "This is comment #{n}" }
  end
end
