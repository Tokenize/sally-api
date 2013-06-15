require 'faker'
FactoryGirl.define do
  factory :location do
    time { Time.now }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    direction { ["N", "E", "S", "W"].sample }
    speed { rand(120) }
    association :trip
  end
end
