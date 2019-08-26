FactoryBot.define do
  factory :message, class: Message do
    sequence(:content) { |n| "Message #{n}" }
  end
end
