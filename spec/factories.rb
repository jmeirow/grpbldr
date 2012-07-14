FactoryGirl.define do

  
  sequence(:email) { |n| "foo#{n}mydomain.com" }

  factory :user do
    email
    password "xxx"
    password_confirmation  'xxx'
  end
end

FactoryGirl.generate :email

