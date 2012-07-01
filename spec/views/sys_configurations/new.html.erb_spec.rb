require 'spec_helper'

describe "sys_configurations/new" do
  before(:each) do
    assign(:sys_configuration, stub_model(SysConfiguration,
      :config_key => "MyString",
      :config_value => "MyString"
    ).as_new_record)
  end

  it "renders new sys_configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sys_configurations_path, :method => "post" do
      assert_select "input#sys_configuration_config_key", :name => "sys_configuration[config_key]"
      assert_select "input#sys_configuration_config_value", :name => "sys_configuration[config_value]"
    end
  end
end
