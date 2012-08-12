require 'spec_helper'

describe "contest_signups/new" do
  before(:each) do
    assign(:contest_signup, stub_model(ContestSignup,
      :club_id => "MyString",
      :role_description => "MyString",
      :member_id => "MyString"
    ).as_new_record)
  end

  it "renders new contest_signup form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contest_signups_path, :method => "post" do
      assert_select "input#contest_signup_club_id", :name => "contest_signup[club_id]"
      assert_select "input#contest_signup_role_description", :name => "contest_signup[role_description]"
      assert_select "input#contest_signup_member_id", :name => "contest_signup[member_id]"
    end
  end
end
