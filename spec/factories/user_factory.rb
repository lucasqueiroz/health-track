FactoryBot.define do
  factory :user, class: User do
    name { 'Lucas Queiroz' }
    email { 'lucascqueiroz97@gmail.com' }
    birthday { '26/02/1997' }
    password { 'password' }
  end

  factory :different_user, class: User do
    name { 'User Two' }
    email { 'lucascqueiroz97@gmail.com.uk' }
    birthday { '26/02/1997' }
    password { 'password' }
  end

  factory :third_user, class: User do
    name { 'User Three' }
    email { 'lucascqueiroz97@gmail.com.ca' }
    birthday { '26/02/1997' }
    password { 'password' }
  end
end