FactoryBot.define do
  factory :workout, class: Workout do
    user
    name { Faker::Name.first_name }
    calories { Faker::Number.between(100, 1000).to_i }
    occurred_at { Faker::Date.between(6.years.ago, Date.today) }
  end

  factory :different_workout, class: Workout do
    association :user, factory: :different_user
    name { Faker::Name.first_name }
    calories { Faker::Number.between(100, 1000).to_i }
    occurred_at { Faker::Date.between(6.years.ago, Date.today) }
  end
end
