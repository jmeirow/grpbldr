require 'spec_helper'

describe "leaders/show" do
  before(:each) do
    @leader = assign(:leader, stub_model(Leader,
      :club_id => 1,
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
