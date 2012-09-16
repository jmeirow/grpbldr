# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    major 1
    minor 1
    patch 1
    description "MyText"
  end
end
