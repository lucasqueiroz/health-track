FactoryBot.define do
  factory :height, class: Height do
    user
    measurement { 1.73 }
    measured_at { '22/10/2018' }
  end

  factory :different_height, class: Height do
    association :user, factory: :different_user
    measurement { 1.73 }
    measured_at { '22/10/2018' }
  end
end