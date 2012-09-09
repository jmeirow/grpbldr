require 'spec_helper'

describe "role_group_associations/show" do
  before(:each) do
    @role_group_association = assign(:role_group_association, stub_model(RoleGroupAssociation,
      :role_id => 1,
      :role_group_id => 2,
      :club_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
