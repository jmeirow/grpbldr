require 'spec_helper'

describe "leader_histories/show" do
  before(:each) do
    @leader_history = assign(:leader_history, stub_model(LeaderHistory,
      :leader_id => 1,
      :member_id => 2,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
