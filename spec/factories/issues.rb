# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    status "MyString"
    type ""
    estimated_hours "9.99"
    worked_hours "9.99"
    number 1
  end
end
