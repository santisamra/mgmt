# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    organization "Wolox"
    sequence(:name) { |n| "project#{n}" }
  end
end
