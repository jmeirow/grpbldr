require 'spec_helper'

describe "role_groups/index" do
  before(:each) do
    assign(:role_groups, [
      stub_model(RoleGroup),
      stub_model(RoleGroup)
    ])
  end

  it "renders a list of role_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
