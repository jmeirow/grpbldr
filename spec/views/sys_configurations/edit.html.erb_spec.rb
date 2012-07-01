require 'spec_helper'

describe "sys_configurations/edit" do
  before(:each) do
    @sys_configuration = assign(:sys_configuration, stub_model(SysConfiguration,
      :config_key => "MyString",
      :config_value => "MyString"
    ))
  end

  it "renders the edit sys_configuration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sys_configurations_path(@sys_configuration), :method => "post" do
      assert_select "input#sys_configuration_config_key", :name => "sys_configuration[config_key]"
      assert_select "input#sys_configuration_config_value", :name => "sys_configuration[config_value]"
    end
  end
end
