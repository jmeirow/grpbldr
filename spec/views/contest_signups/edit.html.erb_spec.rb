require 'spec_helper'

describe "contest_signups/edit" do
  before(:each) do
    @contest_signup = assign(:contest_signup, stub_model(ContestSignup,
      :club_id => "MyString",
      :role_description => "MyString",
      :member_id => "MyString"
    ))
  end

  it "renders the edit contest_signup form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contest_signups_path(@contest_signup), :method => "post" do
      assert_select "input#contest_signup_club_id", :name => "contest_signup[club_id]"
      assert_select "input#contest_signup_role_description", :name => "contest_signup[role_description]"
      assert_select "input#contest_signup_member_id", :name => "contest_signup[member_id]"
    end
  end
end
