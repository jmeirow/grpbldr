require 'spec_helper'

describe "agenda_tops/show" do
  before(:each) do
    @agenda_top = assign(:agenda_top, stub_model(AgendaTop,
      :agenda_definition_id => 1,
      :heading_text => "Heading Text",
      :body_text => "MyText",
      :image_source => "Image Source",
      :image_width => 2,
      :image_height => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Heading Text/)
    rendered.should match(/MyText/)
    rendered.should match(/Image Source/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
