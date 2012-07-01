require 'spec_helper'

describe "agenda_definitions/show" do
  before(:each) do
    @agenda_definition = assign(:agenda_definition, stub_model(AgendaDefinition,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
