FactoryBot.define do
 factory :user do
   user_name {"市川"}
   email {"xxx@xxx.com"}
   password {"password"}
   password_confirmation {"password"}
   admin {false}
 end

 factory :admin_user, class: User do
   user_name {"洋平さん"}
   email  {"yyy@yyy.com"}
   password {"password"}
   password_confirmation {"password"}
   admin {true}
 end
end
