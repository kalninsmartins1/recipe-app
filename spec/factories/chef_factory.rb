FactoryBot.define do
  factory :chef, class: Chef do
    sequence(:name) { |n| "Joe#{n}" }
    sequence(:email) { "#{name}@test.com" }

    password { 'password' }
    admin { false }
  end

  factory :admin_chef, class: Chef do
    name { 'Jim' }
    email { 'jimkenny@test.com' }
    password { 'password' }
    admin { true }
  end
end
