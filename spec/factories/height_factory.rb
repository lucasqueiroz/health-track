FactoryBot.define do
  factory :height, class: Height do
    user
    measurement { 1.73 }
    measured_at { '22/10/2018' }
  end
end