require 'spec_helper'

describe "member_notification_preferences/show" do
  before(:each) do
    @member_notification_preference = assign(:member_notification_preference, stub_model(MemberNotificationPreference,
      :member_id => 1,
      :notification_type_id => 2,
      :enabled => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
  end
end
