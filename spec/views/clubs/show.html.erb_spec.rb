require 'spec_helper'

describe "clubs/show.html.erb" do
  before(:each) do
    @club = assign(:club, stub_model(Club))
  end

  it "renders attributes in <p>" do
    render
  end
end
