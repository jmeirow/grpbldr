require 'spec_helper'

describe "member_notification_preferences/edit" do
  before(:each) do
    @member_notification_preference = assign(:member_notification_preference, stub_model(MemberNotificationPreference,
      :member_id => 1,
      :notification_type_id => 1,
      :enabled => false
    ))
  end

  it "renders the edit member_notification_preference form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => member_notification_preferences_path(@member_notification_preference), :method => "post" do
      assert_select "input#member_notification_preference_member_id", :name => "member_notification_preference[member_id]"
      assert_select "input#member_notification_preference_notification_type_id", :name => "member_notification_preference[notification_type_id]"
      assert_select "input#member_notification_preference_enabled", :name => "member_notification_preference[enabled]"
    end
  end
end
