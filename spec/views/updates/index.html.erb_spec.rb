require 'spec_helper'

describe "updates/index" do
  before(:each) do
    assign(:updates, [
      stub_model(Update,
        :new => "New"
      ),
      stub_model(Update,
        :new => "New"
      )
    ])
  end

  it "renders a list of updates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "New".to_s, :count => 2
  end
end
