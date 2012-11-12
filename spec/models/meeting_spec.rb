require 'spec_helper'
require 'factory_girl'
 


  

describe Meeting do



 

  it "should not be considered valid if name is missing" do
    FactoryGirl.build(:club, :name => nil).should_not be_valid
  end

  it "should not be considered valid email_enabled is missing" do
    FactoryGirl.build(:club, :email_enabled => nil).should_not be_valid
  end

  it "should be considered valid if domain is missing before insert" do
     FactoryGirl.build(:club,  :domain => nil).should  be_valid
  end 

  it "should be considered valid if domain = club id " do
     FactoryGirl.build(:club,  :domain => "100").should be_valid
  end

  it "should not be considered valid if domain is number and not the same as club id" do
    FactoryGirl.build(:club,  :domain => "9999").should_not be_valid 
  end

  it "should not be considered valid if domain contains blanks" do
    FactoryGirl.build(:club, :domain => 'has blanks').should_not be_valid
  end



end
