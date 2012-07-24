require 'spec_helper'

describe "agreements/show" do
  before(:each) do
    @agreement = assign(:agreement, stub_model(Agreement,
      :club_id => 1,
      :club_monthly_rate => "9.99",
      :member_monthly_rate => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
  end
end
