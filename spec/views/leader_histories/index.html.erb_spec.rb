require 'spec_helper'

describe "leader_histories/index" do
  before(:each) do
    assign(:leader_histories, [
      stub_model(LeaderHistory,
        :leader_id => 1,
        :member_id => 2,
        :notes => "MyText"
      ),
      stub_model(LeaderHistory,
        :leader_id => 1,
        :member_id => 2,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of leader_histories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
