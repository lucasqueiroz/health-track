FactoryBot.define do
  factory :food, class: Food do
    user
    name { "Poutine" }
    calories { 740 }
    occurred_at { "2018-12-09" }
  end

  factory :different_food, class: Food do
    association :user, factory: :different_user
    name { "Poutine" }
    calories { 740 }
    occurred_at { "2018-12-09" }
  end
end
