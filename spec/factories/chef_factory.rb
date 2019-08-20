FactoryBot.define do
  factory :chef, class: Chef do
    name { 'John' }
    email { 'johntreec@test.com' }
    password { 'password' }
    admin { false }
  end

  factory :chef_a, class: Chef do
    name { 'Kate' }
    email { 'kate123@test.com' }
    password { 'password' }
    admin { false }
  end

  factory :chef_b, class: Chef do
    name { 'Jimmy' }
    email { 'jimmy123@test.com' }
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
