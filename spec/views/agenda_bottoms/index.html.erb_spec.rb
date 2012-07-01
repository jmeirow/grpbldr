require 'spec_helper'

describe "agenda_bottoms/index" do
  before(:each) do
    assign(:agenda_bottoms, [
      stub_model(AgendaBottom,
        :agenda_definition_id => 1,
        :body_text => "MyText"
      ),
      stub_model(AgendaBottom,
        :agenda_definition_id => 1,
        :body_text => "MyText"
      )
    ])
  end

  it "renders a list of agenda_bottoms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
