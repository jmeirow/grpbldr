require 'spec_helper'

describe "sys_configurations/index" do
  before(:each) do
    assign(:sys_configurations, [
      stub_model(SysConfiguration,
        :config_key => "Config Key",
        :config_value => "Config Value"
      ),
      stub_model(SysConfiguration,
        :config_key => "Config Key",
        :config_value => "Config Value"
      )
    ])
  end

  it "renders a list of sys_configurations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Config Key".to_s, :count => 2
    assert_select "tr>td", :text => "Config Value".to_s, :count => 2
  end
end
