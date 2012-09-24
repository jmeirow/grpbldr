require 'spec_helper'
require 'factory_girl'
 

describe Club do


 
  it "should have a valid factory" do
    FactoryGirl.build(:club).should be_valid
  end

  it "should not be considered valid if name is missing" do
    FactoryGirl.build(:club, name: nil).should_not be_valid
  end

  it "should not be considered valid mail_enabled is missing" do
    FactoryGirl.build(:club, email_enabled: nil).should_not be_valid
  end

  it "should be considered valid if domain is missing before insert" do
     FactoryGirl.create(:club,  domain: nil).should  be_valid
  end 

  it "should be considered valid if domain = club id " do
     FactoryGirl.create(:club,  domain: "100").should be_valid
  end

  it "should not be considered valid if domain is number and not the same as club id" do
    a = FactoryGirl.create(:club)
    a.should be_valid
    a.domain = '9999'
    a.should_not be_valid    
  end

  it "should not be considered valid if domain contains blanks" do
    c = Club.create(:name => 'someclub', :email_enabled => true )
    c.domain = 'has blanks'
    c.should_not be_valid
  end
  



end
