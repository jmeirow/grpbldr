require 'spec_helper'

describe "role_groups/edit" do
  before(:each) do
    @role_group = assign(:role_group, stub_model(RoleGroup))
  end

  it "renders the edit role_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => role_groups_path(@role_group), :method => "post" do
    end
  end
end
