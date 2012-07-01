require 'spec_helper'

describe "agenda_definitions/new" do
  before(:each) do
    assign(:agenda_definition, stub_model(AgendaDefinition,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new agenda_definition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agenda_definitions_path, :method => "post" do
      assert_select "input#agenda_definition_name", :name => "agenda_definition[name]"
      assert_select "textarea#agenda_definition_description", :name => "agenda_definition[description]"
    end
  end
end
