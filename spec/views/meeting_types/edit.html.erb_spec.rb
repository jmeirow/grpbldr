require 'spec_helper'

describe "meeting_types/edit" do
  before(:each) do
    @meeting_type = assign(:meeting_type, stub_model(MeetingType,
      :description => "MyString",
      :hour => 1,
      :minute => 1,
      :am_pm => "MyString",
      :is_default => false,
      :club_id => 1
    ))
  end

  it "renders the edit meeting_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meeting_types_path(@meeting_type), :method => "post" do
      assert_select "input#meeting_type_description", :name => "meeting_type[description]"
      assert_select "input#meeting_type_hour", :name => "meeting_type[hour]"
      assert_select "input#meeting_type_minute", :name => "meeting_type[minute]"
      assert_select "input#meeting_type_am_pm", :name => "meeting_type[am_pm]"
      assert_select "input#meeting_type_is_default", :name => "meeting_type[is_default]"
      assert_select "input#meeting_type_club_id", :name => "meeting_type[club_id]"
    end
  end
end
