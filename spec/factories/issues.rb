# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    issue_type "feature"
    status "not_started"
    estimated_hours "5"
    github_status "open"
    sequence(:number) { |n| n }
  end
end
