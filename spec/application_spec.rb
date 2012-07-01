require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../app/models/role_master_application.rb')


describe RoleMasterApplication do
 
  it "should indicate if new assignments are required" do
   	RoleMasterApplication.new.should be_require_assignments
  end 
end
