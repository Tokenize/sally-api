require 'faker'
FactoryGirl.define do
  factory :trip do
    name { Faker::Company.bs }
    description { Faker::Lorem.paragraph }
    start_at { Time.now }
    end_at { Time.at(Time.now + rand(10000)) }
    association :user
  end
end
