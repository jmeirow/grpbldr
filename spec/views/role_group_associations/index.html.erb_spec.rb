require 'spec_helper'

describe "role_group_associations/index" do
  before(:each) do
    assign(:role_group_associations, [
      stub_model(RoleGroupAssociation,
        :role_id => 1,
        :role_group_id => 2,
        :club_id => 3
      ),
      stub_model(RoleGroupAssociation,
        :role_id => 1,
        :role_group_id => 2,
        :club_id => 3
      )
    ])
  end

  it "renders a list of role_group_associations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
