FactoryBot.define do
  factory :message, class: Message do
    content { 'This is awesome !' }
  end

  factory :message_a, class: Message do
    content { 'Today is a great day !' }
  end

  factory :message_b, class: Message do
    content { 'Fantastico !' }
  end
end
