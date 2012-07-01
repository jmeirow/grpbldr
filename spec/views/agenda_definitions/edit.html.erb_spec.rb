require 'spec_helper'

describe "agenda_definitions/edit" do
  before(:each) do
    @agenda_definition = assign(:agenda_definition, stub_model(AgendaDefinition,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit agenda_definition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agenda_definitions_path(@agenda_definition), :method => "post" do
      assert_select "input#agenda_definition_name", :name => "agenda_definition[name]"
      assert_select "textarea#agenda_definition_description", :name => "agenda_definition[description]"
    end
  end
end
