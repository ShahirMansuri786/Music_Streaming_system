FactoryBot.define do
  factory :song do
    association :user
    association :category
    name { Faker::Name.name }
    singer_name { Faker::Name.name }
  end
end
