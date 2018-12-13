FactoryBot.define do
  factory :weight, class: Weight do
    user
    measurement { Faker::Number.between(70, 100).to_i }
    measured_at { Faker::Date.between(6.years.ago, Date.today) }
  end

  factory :different_weight, class: Weight do
    association :user, factory: :different_user
    measurement { Faker::Number.between(70, 100).to_i }
    measured_at { Faker::Date.between(6.years.ago, Date.today) }
  end
end
