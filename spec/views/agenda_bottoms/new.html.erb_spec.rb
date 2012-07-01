require 'spec_helper'

describe "agenda_bottoms/new" do
  before(:each) do
    assign(:agenda_bottom, stub_model(AgendaBottom,
      :agenda_definition_id => 1,
      :body_text => "MyText"
    ).as_new_record)
  end

  it "renders new agenda_bottom form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agenda_bottoms_path, :method => "post" do
      assert_select "input#agenda_bottom_agenda_definition_id", :name => "agenda_bottom[agenda_definition_id]"
      assert_select "textarea#agenda_bottom_body_text", :name => "agenda_bottom[body_text]"
    end
  end
end
