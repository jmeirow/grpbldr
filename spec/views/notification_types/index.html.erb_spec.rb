require 'spec_helper'

describe "notification_types/index" do
  before(:each) do
    assign(:notification_types, [
      stub_model(NotificationType,
        :mailer_type => "Mailer Type",
        :description => "MyText"
      ),
      stub_model(NotificationType,
        :mailer_type => "Mailer Type",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of notification_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mailer Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
