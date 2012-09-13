require 'spec_helper'

describe "meeting_types/index" do
  before(:each) do
    assign(:meeting_types, [
      stub_model(MeetingType,
        :description => "Description",
        :hour => 1,
        :minute => 2,
        :am_pm => "Am Pm",
        :is_default => false,
        :club_id => 3
      ),
      stub_model(MeetingType,
        :description => "Description",
        :hour => 1,
        :minute => 2,
        :am_pm => "Am Pm",
        :is_default => false,
        :club_id => 3
      )
    ])
  end

  it "renders a list of meeting_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Am Pm".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
