require 'spec_helper'

describe "updates/show" do
  before(:each) do
    @update = assign(:update, stub_model(Update,
      :new => "New"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/New/)
  end
end
