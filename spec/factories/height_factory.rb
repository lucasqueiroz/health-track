FactoryBot.define do
  factory :height, class: Height do
    user
    measurement { Faker::Number.between(1.00, 2.00).to_f }
    measured_at { Faker::Date.between(6.years.ago, Date.today) }
  end

  factory :different_height, class: Height do
    association :user, factory: :different_user
    measurement { Faker::Number.between(1.00, 2.00).to_f }
    measured_at { Faker::Date.between(6.years.ago, Date.today) }
  end
end