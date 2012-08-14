require 'spec_helper'
require 'custom/running_time.rb'

describe RunningTime do
  it "should allow instantiation of AM time" do
    timer = RunningTime.new(10,0,'am')
    timer.to_s.split(' ')[1].should eq('AM')
  end

  it "should allow instantiation of AM time" do
    timer = RunningTime.new(10,0,'pm')
    timer.to_s.split(' ')[1].should eq('PM')
  end

  it "should properly roll over from AM to PM" do
    timer = RunningTime.new(10,0,'am')
    timer + 150
    timer.to_s.should eq('12:30 PM')
  end


  it "should properly roll over from PM to AM" do
    timer = RunningTime.new(10,0,'pm')
    timer + 150
    timer.to_s.should eq('12:30 AM')
  end


  it "should get the same time after adding 24 hours to initial time when initialized with AM time" do
    timer = RunningTime.new(10,0,'am')
    day = 24 * 60
    timer + day
    timer.to_s.should eq('10:00 AM')
  end

  it "should get the same time after adding 24 hours to initial time when initialized with PM time" do
    timer = RunningTime.new(10,0,'PM')
    day = 24 * 60
    timer + day
    timer.to_s.should eq('10:00 PM')
  end

  it "should properly roll over the hour when the minutes change while in an AM time" do
    timer = RunningTime.new(10,58,'AM')
    timer + 4
    timer.to_s.should eq('11:02 AM')
  end



  it "should properly roll over the hour when the minutes change while in an PM time" do
    timer = RunningTime.new(10,58,'PM')
    timer + 4
    timer.to_s.should eq('11:02 PM')
  end




  it "should properly roll over the hour and AM/PM when the minutes change while in an AM time" do
    timer = RunningTime.new(11,58,'AM')
    timer + 4
    timer.to_s.should eq('12:02 PM')
  end



  it "should properly roll over the hour and AM/PM when the minutes change while in an PM time" do
    timer = RunningTime.new(11,58,'PM')
    timer + 4
    timer.to_s.should eq('12:02 AM')
  end

end
