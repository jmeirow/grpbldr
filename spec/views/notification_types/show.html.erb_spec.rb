require 'spec_helper'

describe "notification_types/show" do
  before(:each) do
    @notification_type = assign(:notification_type, stub_model(NotificationType,
      :mailer_type => "Mailer Type",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mailer Type/)
    rendered.should match(/MyText/)
  end
end
