require 'spec_helper'

describe "role_group_associations/new" do
  before(:each) do
    assign(:role_group_association, stub_model(RoleGroupAssociation,
      :role_id => 1,
      :role_group_id => 1,
      :club_id => 1
    ).as_new_record)
  end

  it "renders new role_group_association form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => role_group_associations_path, :method => "post" do
      assert_select "input#role_group_association_role_id", :name => "role_group_association[role_id]"
      assert_select "input#role_group_association_role_group_id", :name => "role_group_association[role_group_id]"
      assert_select "input#role_group_association_club_id", :name => "role_group_association[club_id]"
    end
  end
end
