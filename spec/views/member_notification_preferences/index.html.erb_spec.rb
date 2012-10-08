require 'spec_helper'

describe "member_notification_preferences/index" do
  before(:each) do
    assign(:member_notification_preferences, [
      stub_model(MemberNotificationPreference,
        :member_id => 1,
        :notification_type_id => 2,
        :enabled => false
      ),
      stub_model(MemberNotificationPreference,
        :member_id => 1,
        :notification_type_id => 2,
        :enabled => false
      )
    ])
  end

  it "renders a list of member_notification_preferences" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
