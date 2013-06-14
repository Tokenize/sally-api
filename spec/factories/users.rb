# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Phil"
    last_name "Johnson"
    sequence(:email) { |n| "philjohnson#{n}@example.com" }
  end
end
