FactoryBot.define do
  factory :comment, class: Comment do
    description { 'This was spectacularly great !' }
  end

  factory :comment_a, class: Comment do
    description { 'Magnificent !' }
  end

  factory :comment_b, class: Comment do
    description { 'Wonderfully great !' }
  end
end
