FactoryBot.define do
  factory :workout do
    user
    name { "Running" }
    calories { 500 }
    occurred_at { "2018-12-09" }
  end
end
