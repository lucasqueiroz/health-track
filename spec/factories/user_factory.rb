FactoryBot.define do
  factory :user, class: User do
    name { 'Lucas Queiroz' }
    email { 'lucascqueiroz97@gmail.com' }
    birthday { '26/02/1997' }
    password { 'password' }
  end
end