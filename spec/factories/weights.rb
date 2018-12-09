FactoryBot.define do
  factory :weight do
    user
    measurement { 50 }
    measured_at { "2018-12-09" }
  end
end
