FactoryBot.define do
  factory :user do
    user_name { "テストユーザー" }
    email { "test@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end
end
