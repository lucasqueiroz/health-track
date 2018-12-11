FactoryBot.define do
  factory :workout, class: Workout do
    user
    name { "Running" }
    calories { 500 }
    occurred_at { "2018-12-09" }
  end

  factory :different_workout, class: Workout do
    association :user, factory: :different_user
    name { "Running" }
    calories { 500 }
    occurred_at { "2018-12-09" }
  end
end
