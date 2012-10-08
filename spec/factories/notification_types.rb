# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_type do
    mailer_type "MyString"
    description "MyText"
  end
end
