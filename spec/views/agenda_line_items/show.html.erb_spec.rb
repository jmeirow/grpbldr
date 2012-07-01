require 'spec_helper'

describe "agenda_line_items/show" do
  before(:each) do
    @agenda_line_item = assign(:agenda_line_item, stub_model(AgendaLineItem,
      :agenda_definition_id => 1,
      :sequence_nbr => 2,
      :time_format => "Time Format",
      :line_item_text => "MyText",
      :person_display_name => "Person Display Name",
      :person_display_name_source => "Person Display Name Source"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Time Format/)
    rendered.should match(/MyText/)
    rendered.should match(/Person Display Name/)
    rendered.should match(/Person Display Name Source/)
  end
end
