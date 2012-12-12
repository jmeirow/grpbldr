# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    txn_id "MyString"
    action 1
    user_name "MyString"
    model_name "MyString"
    data_before "MyText"
    data_after "MyText"
    changed_data "MyText"
  end
end
