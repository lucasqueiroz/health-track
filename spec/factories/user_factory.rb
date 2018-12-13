FactoryBot.define do
  factory :user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(18, 65) }
    password { Faker::Name.first_name.downcase }
  end

  factory :different_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(18, 65) }
    password { Faker::Name.first_name.downcase }
  end

  factory :third_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(18, 65) }
    password { Faker::Name.first_name.downcase }
  end
end