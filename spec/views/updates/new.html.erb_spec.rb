require 'spec_helper'

describe "updates/new" do
  before(:each) do
    assign(:update, stub_model(Update).as_new_record)
  end

  it "renders new update form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => updates_path, :method => "post" do
    end
  end
end
