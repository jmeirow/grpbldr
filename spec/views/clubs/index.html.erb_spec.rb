require 'spec_helper'

describe "clubs/index.html.erb" do
  before(:each) do
    assign(:clubs, [
      stub_model(Club),
      stub_model(Club)
    ])
  end

  it "renders a list of clubs" do
    render
  end
end
