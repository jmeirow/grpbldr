require 'spec_helper'

describe "agenda_line_items/edit" do
  before(:each) do
    @agenda_line_item = assign(:agenda_line_item, stub_model(AgendaLineItem,
      :agenda_definition_id => 1,
      :sequence_nbr => 1,
      :time_format => "MyString",
      :line_item_text => "MyText",
      :person_display_name => "MyString",
      :person_display_name_source => "MyString"
    ))
  end

  it "renders the edit agenda_line_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agenda_line_items_path(@agenda_line_item), :method => "post" do
      assert_select "input#agenda_line_item_agenda_definition_id", :name => "agenda_line_item[agenda_definition_id]"
      assert_select "input#agenda_line_item_sequence_nbr", :name => "agenda_line_item[sequence_nbr]"
      assert_select "input#agenda_line_item_time_format", :name => "agenda_line_item[time_format]"
      assert_select "textarea#agenda_line_item_line_item_text", :name => "agenda_line_item[line_item_text]"
      assert_select "input#agenda_line_item_person_display_name", :name => "agenda_line_item[person_display_name]"
      assert_select "input#agenda_line_item_person_display_name_source", :name => "agenda_line_item[person_display_name_source]"
    end
  end
end
