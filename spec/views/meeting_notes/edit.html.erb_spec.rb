require 'spec_helper'

describe "meeting_notes/edit" do
  before(:each) do
    @meeting_note = assign(:meeting_note, stub_model(MeetingNote,
      :member_name => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit meeting_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meeting_notes_path(@meeting_note), :method => "post" do
      assert_select "input#meeting_note_member_name", :name => "meeting_note[member_name]"
      assert_select "textarea#meeting_note_body", :name => "meeting_note[body]"
    end
  end
end
