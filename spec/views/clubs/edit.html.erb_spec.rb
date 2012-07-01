require 'spec_helper'

describe "clubs/edit.html.erb" do
  before(:each) do
    @club = assign(:club, stub_model(Club))
  end

  it "renders the edit club form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clubs_path(@club), :method => "post" do
    end
  end
end
