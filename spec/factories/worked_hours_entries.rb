# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :worked_hours_entry do
    amount 1
    date Date.today
  end
end
