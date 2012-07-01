require 'spec_helper'

describe "updates/edit" do
  before(:each) do
    @update = assign(:update, stub_model(Update,
      :new => "MyString"
    ))
  end

  it "renders the edit update form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => updates_path(@update), :method => "post" do
      assert_select "input#update_new", :name => "update[new]"
    end
  end
end
