require 'spec_helper'

describe "leaders/edit" do
  before(:each) do
    @leader = assign(:leader, stub_model(Leader,
      :club_id => 1,
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit leader form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => leaders_path(@leader), :method => "post" do
      assert_select "input#leader_club_id", :name => "leader[club_id]"
      assert_select "input#leader_title", :name => "leader[title]"
      assert_select "textarea#leader_description", :name => "leader[description]"
    end
  end
end
