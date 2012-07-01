require 'spec_helper'

describe "agenda_line_items/index" do
  before(:each) do
    assign(:agenda_line_items, [
      stub_model(AgendaLineItem,
        :agenda_definition_id => 1,
        :sequence_nbr => 2,
        :time_format => "Time Format",
        :line_item_text => "MyText",
        :person_display_name => "Person Display Name",
        :person_display_name_source => "Person Display Name Source"
      ),
      stub_model(AgendaLineItem,
        :agenda_definition_id => 1,
        :sequence_nbr => 2,
        :time_format => "Time Format",
        :line_item_text => "MyText",
        :person_display_name => "Person Display Name",
        :person_display_name_source => "Person Display Name Source"
      )
    ])
  end

  it "renders a list of agenda_line_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Time Format".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Person Display Name".to_s, :count => 2
    assert_select "tr>td", :text => "Person Display Name Source".to_s, :count => 2
  end
end
