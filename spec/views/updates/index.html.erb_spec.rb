require 'spec_helper'

describe "updates/index" do
  before(:each) do
    assign(:updates, [
      stub_model(Update),
      stub_model(Update)
    ])
  end

  it "renders a list of updates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
