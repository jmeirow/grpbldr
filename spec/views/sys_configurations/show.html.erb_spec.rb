require 'spec_helper'

describe "sys_configurations/show" do
  before(:each) do
    @sys_configuration = assign(:sys_configuration, stub_model(SysConfiguration,
      :config_key => "Config Key",
      :config_value => "Config Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Config Key/)
    rendered.should match(/Config Value/)
  end
end
