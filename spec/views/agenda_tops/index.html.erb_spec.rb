require 'spec_helper'

describe "agenda_tops/index" do
  before(:each) do
    assign(:agenda_tops, [
      stub_model(AgendaTop,
        :agenda_definition_id => 1,
        :heading_text => "Heading Text",
        :body_text => "MyText",
        :image_source => "Image Source",
        :image_width => 2,
        :image_height => 3
      ),
      stub_model(AgendaTop,
        :agenda_definition_id => 1,
        :heading_text => "Heading Text",
        :body_text => "MyText",
        :image_source => "Image Source",
        :image_width => 2,
        :image_height => 3
      )
    ])
  end

  it "renders a list of agenda_tops" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Heading Text".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image Source".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
