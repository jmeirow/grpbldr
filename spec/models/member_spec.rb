require 'spec_helper'
require 'factory_girl'

Factory.define :user, :class => User do |f|
  f.email   'useremail'
  f.password  'xxx'
  f.password_confirmation  'xxx'
end

describe User do

  before(:all) do 
    User.delete_all
    @user = Factory(:user)
  end
  
  it "should not be considered valid if email address is missing" do
    @user.email = ''
    @user.should_not be_valid
  end

  it "should not be considered valid if password is missing" do
      @user.password = ''
      @user.should_not be_valid
  end
    
  it "should not be considered valid if password_confirmation is missing" do
    @user.password_confirmation = ''
    @user.should_not be_valid
  end
  
  it "should not be considered valid if password does not match password_confirmation is missing" do
    @user.password = 'abc'
    @user.password_confirmation = '123'
    @user.should_not be_valid
  end
  
  it "should  be considered valid if email, password and confirmation are present and password/confirmtion are equal" do
    @user.email = 'user@domain.com'
    @user.password = 'abc'
    @user.password_confirmation = 'abc'
    @user.should be_valid
  end

end
