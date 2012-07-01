require 'spec_helper'

describe "meeting_notes/index" do
  before(:each) do
    assign(:meeting_notes, [
      stub_model(MeetingNote,
        :member_name => "Member Name",
        :body => "MyText"
      ),
      stub_model(MeetingNote,
        :member_name => "Member Name",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of meeting_notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Member Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
