require 'spec_helper'

describe "notification_types/edit" do
  before(:each) do
    @notification_type = assign(:notification_type, stub_model(NotificationType,
      :mailer_type => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit notification_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notification_types_path(@notification_type), :method => "post" do
      assert_select "input#notification_type_mailer_type", :name => "notification_type[mailer_type]"
      assert_select "textarea#notification_type_description", :name => "notification_type[description]"
    end
  end
end
