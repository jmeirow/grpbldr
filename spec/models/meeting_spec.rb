require 'spec_helper'
require 'factory_girl'

Factory.define :club, :class => Club do |f|
  f.name   'my_club_name'
end

Factory.define :meeting, :class => Meeting do |f|
  f.name   'my_club_name'
end

describe Meeting do
  before(:all) do 
    Club.delete_all
    Meeting.delete_all
    @club = Factory(:club)
    @meeting = Factory(:meeting)
  end
  
  it "should not be considered valid if name is missing" do
    @meeting.name = ''
    @meeting.should_not be_valid
  end
end


