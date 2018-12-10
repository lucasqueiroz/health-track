FactoryBot.define do
  factory :food do
    user
    name { "Poutine" }
    calories { 740 }
    occurred_at { "2018-12-09" }
  end
end
