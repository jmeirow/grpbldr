require 'spec_helper'

describe "role_groups/show" do
  before(:each) do
    @role_group = assign(:role_group, stub_model(RoleGroup))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
