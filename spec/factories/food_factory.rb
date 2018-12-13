FactoryBot.define do
  factory :food, class: Food do
    user
    name { Faker::Food.dish }
    calories { Faker::Number.between(100, 1000).to_i }
    occurred_at { Faker::Date.between(6.years.ago, Date.today) }
  end

  factory :different_food, class: Food do
    association :user, factory: :different_user
    name { Faker::Food.dish }
    calories { Faker::Number.between(100, 1000).to_i }
    occurred_at { Faker::Date.between(6.years.ago, Date.today) }
  end
end
