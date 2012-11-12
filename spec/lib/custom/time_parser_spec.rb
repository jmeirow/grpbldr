require 'spec_helper'
require 'custom/time_parser.rb'


describe TimeParser, " a class that parses time strings into an object and properties." do 
 
  it " should create an instance that is a TimeParser " do 
    p = TimeParser.new("")
    p.class.should eq(TimeParser)
  end

  it " should be valid if noon is passed. " do 
    p = TimeParser.new("12:00 PM")
    p.should be_valid
  end

  it " should be valid if bad hour passed. " do 
    p = TimeParser.new("13:00 PM")
    p.should_not be_valid
  end

  it " should be valid if bad hour passed. " do 
    p = TimeParser.new("00:00 PM")
    p.should_not be_valid
  end  
  
  it " should be valid if bad hour passed. " do 
    p = TimeParser.new(":00 PM")
    p.should_not be_valid
  end 


  it " should be valid if bad minute passed. " do 
    p = TimeParser.new("12:60 PM")
    p.should_not be_valid
  end

  it " should be valid if bad minute passed. " do 
    p = TimeParser.new("1:00 PM")
    p.hour.should eq(1)
    p.minute.should eq(0)
    p.am_pm.should eq('PM')
  end

  it " should be valid if bad minute passed. " do 
    p = TimeParser.new("10:00 PM")
    p.hour.should eq(10)
  end

  it " should be valid if bad minute passed. " do 
    p = TimeParser.new("12:00 PM")
    p.hour.should eq(12)
  end


 
end