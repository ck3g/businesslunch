# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_group do
    user
    group
    balance 0
  end
end
