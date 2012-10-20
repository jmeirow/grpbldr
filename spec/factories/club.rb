# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :club do
  	id 100
    name "Factory Club"
    email_enabled true
  	domain "100"
    before(:create) { Club.destroy_all }
  end
end


 