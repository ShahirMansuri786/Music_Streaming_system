FactoryBot.define do
  factory :song_playlist do 
    association :playlist
    association :song
  end
end
