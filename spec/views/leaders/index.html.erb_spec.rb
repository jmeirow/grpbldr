require 'spec_helper'

describe "leaders/index" do
  before(:each) do
    assign(:leaders, [
      stub_model(Leader,
        :club_id => 1,
        :title => "Title",
        :description => "MyText"
      ),
      stub_model(Leader,
        :club_id => 1,
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of leaders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
