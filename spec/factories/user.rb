FactoryGirl.define do
  factory :user do
    id 100
    password "xxx"
    password_confirmation  'xxx'
    sequence(:email) { |n| "foo#{n}mydomain.com" }
  end
end

