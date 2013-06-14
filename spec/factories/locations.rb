# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    time "2013-06-13 21:35:50"
    latitude 1.5
    longitude 1.5
    direction "MyString"
    speed 1
    trip nil
  end
end
