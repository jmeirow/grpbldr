require 'spec_helper'

describe "meeting_notes/new" do
  before(:each) do
    assign(:meeting_note, stub_model(MeetingNote,
      :member_name => "MyString",
      :body => "MyText"
    ).as_new_record)
  end

  it "renders new meeting_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meeting_notes_path, :method => "post" do
      assert_select "input#meeting_note_member_name", :name => "meeting_note[member_name]"
      assert_select "textarea#meeting_note_body", :name => "meeting_note[body]"
    end
  end
end
