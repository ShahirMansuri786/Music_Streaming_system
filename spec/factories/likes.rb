FactoryBot.define do
  factory :like do
    association :user
    association :song
  end
end
