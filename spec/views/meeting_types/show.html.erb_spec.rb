require 'spec_helper'

describe "meeting_types/show" do
  before(:each) do
    @meeting_type = assign(:meeting_type, stub_model(MeetingType,
      :description => "Description",
      :hour => 1,
      :minute => 2,
      :am_pm => "Am Pm",
      :is_default => false,
      :club_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Am Pm/)
    rendered.should match(/false/)
    rendered.should match(/3/)
  end
end
