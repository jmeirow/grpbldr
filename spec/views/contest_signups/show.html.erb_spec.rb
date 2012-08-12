require 'spec_helper'

describe "contest_signups/show" do
  before(:each) do
    @contest_signup = assign(:contest_signup, stub_model(ContestSignup,
      :club_id => "Club",
      :role_description => "Role Description",
      :member_id => "Member"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Club/)
    rendered.should match(/Role Description/)
    rendered.should match(/Member/)
  end
end
