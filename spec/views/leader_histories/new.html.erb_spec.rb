require 'spec_helper'

describe "leader_histories/new" do
  before(:each) do
    assign(:leader_history, stub_model(LeaderHistory,
      :leader_id => 1,
      :member_id => 1,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new leader_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => leader_histories_path, :method => "post" do
      assert_select "input#leader_history_leader_id", :name => "leader_history[leader_id]"
      assert_select "input#leader_history_member_id", :name => "leader_history[member_id]"
      assert_select "textarea#leader_history_notes", :name => "leader_history[notes]"
    end
  end
end
