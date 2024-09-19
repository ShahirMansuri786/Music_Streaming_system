FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    user_name { Faker::Internet.username(specifier: 5..10) }  
    email { Faker::Internet.unique.email } 
    password_digest { Faker::Internet.password(min_length: 8) }
    role { "admin" }
  end
end
