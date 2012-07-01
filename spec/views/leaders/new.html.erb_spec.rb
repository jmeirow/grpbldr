require 'spec_helper'

describe "leaders/new" do
  before(:each) do
    assign(:leader, stub_model(Leader,
      :club_id => 1,
      :title => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new leader form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => leaders_path, :method => "post" do
      assert_select "input#leader_club_id", :name => "leader[club_id]"
      assert_select "input#leader_title", :name => "leader[title]"
      assert_select "textarea#leader_description", :name => "leader[description]"
    end
  end
end
