# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email     Faker::Internet.email
    name      Faker::Name.name
    login     Faker::Name.first_name
    provider  'github'
    sequence(:uid) { |n| SecureRandom.hex }
  end
end
