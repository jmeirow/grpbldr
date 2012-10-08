# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member_notification_preference do
    member_id 1
    notification_type_id 1
    enabled false
  end
end
