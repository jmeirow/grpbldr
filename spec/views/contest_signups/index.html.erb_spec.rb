require 'spec_helper'

describe "contest_signups/index" do
  before(:each) do
    assign(:contest_signups, [
      stub_model(ContestSignup,
        :club_id => "Club",
        :role_description => "Role Description",
        :member_id => "Member"
      ),
      stub_model(ContestSignup,
        :club_id => "Club",
        :role_description => "Role Description",
        :member_id => "Member"
      )
    ])
  end

  it "renders a list of contest_signups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Club".to_s, :count => 2
    assert_select "tr>td", :text => "Role Description".to_s, :count => 2
    assert_select "tr>td", :text => "Member".to_s, :count => 2
  end
end
