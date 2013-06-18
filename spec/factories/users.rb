require 'faker'
FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name } 
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(16) }
  end
end
