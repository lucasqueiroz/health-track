FactoryBot.define do
  factory :weight, class: Weight do
    user
    measurement { 50 }
    measured_at { "2018-12-09" }
  end

  factory :different_weight, class: Weight do
    association :user, factory: :different_user
    measurement { 50 }
    measured_at { "2018-12-09" }
  end
end
