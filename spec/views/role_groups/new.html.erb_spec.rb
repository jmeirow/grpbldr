require 'spec_helper'

describe "role_groups/new" do
  before(:each) do
    assign(:role_group, stub_model(RoleGroup).as_new_record)
  end

  it "renders new role_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => role_groups_path, :method => "post" do
    end
  end
end
