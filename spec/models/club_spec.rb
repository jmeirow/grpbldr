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
     FactoryGirl.build(:club,  domain: nil).should  be_valid
  end 

  it "should be considered valid if domain = club id " do
     FactoryGirl.build(:club,  domain: "100").should be_valid
  end

  # it "should not be considered valid if domain is number and not the same as club id" do
  #   a = FactoryGirl.create(:club)
  #   a.should be_valid
  #   id = a.id + 1
  #   a.domain = id.to_s
  #   a.save.should be_valid    
  # end

  # it "should not be considered valid if domain contains blanks" do
  #   FactoryGirl.build(:club, domain: "Name has spaces").should_not be_valid
  # end




end
