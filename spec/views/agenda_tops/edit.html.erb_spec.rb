require 'spec_helper'

describe "agenda_tops/edit" do
  before(:each) do
    @agenda_top = assign(:agenda_top, stub_model(AgendaTop,
      :agenda_definition_id => 1,
      :heading_text => "MyString",
      :body_text => "MyText",
      :image_source => "MyString",
      :image_width => 1,
      :image_height => 1
    ))
  end

  it "renders the edit agenda_top form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agenda_tops_path(@agenda_top), :method => "post" do
      assert_select "input#agenda_top_agenda_definition_id", :name => "agenda_top[agenda_definition_id]"
      assert_select "input#agenda_top_heading_text", :name => "agenda_top[heading_text]"
      assert_select "textarea#agenda_top_body_text", :name => "agenda_top[body_text]"
      assert_select "input#agenda_top_image_source", :name => "agenda_top[image_source]"
      assert_select "input#agenda_top_image_width", :name => "agenda_top[image_width]"
      assert_select "input#agenda_top_image_height", :name => "agenda_top[image_height]"
    end
  end
end
