require 'spec_helper'

describe "agenda_bottoms/show" do
  before(:each) do
    @agenda_bottom = assign(:agenda_bottom, stub_model(AgendaBottom,
      :agenda_definition_id => 1,
      :body_text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
  end
end
