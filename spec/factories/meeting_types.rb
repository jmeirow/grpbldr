# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meeting_type do
    club_id 1
    description "MyString"
    is_default false
  end
end
