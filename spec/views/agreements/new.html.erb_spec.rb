require 'spec_helper'

describe "agreements/new" do
  before(:each) do
    assign(:agreement, stub_model(Agreement,
      :club_id => 1,
      :club_monthly_rate => "9.99",
      :member_monthly_rate => "9.99"
    ).as_new_record)
  end

  it "renders new agreement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agreements_path, :method => "post" do
      assert_select "input#agreement_club_id", :name => "agreement[club_id]"
      assert_select "input#agreement_club_monthly_rate", :name => "agreement[club_monthly_rate]"
      assert_select "input#agreement_member_monthly_rate", :name => "agreement[member_monthly_rate]"
    end
  end
end
