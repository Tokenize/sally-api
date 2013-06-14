# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    name "MyString"
    description "MyText"
    start_at "2013-06-13 21:18:10"
    end_at "2013-06-13 21:18:10"
    user nil
  end
end
