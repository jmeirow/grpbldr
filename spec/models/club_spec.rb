require 'spec_helper'

require 'factory_girl'

Factory.define :club, :class => Club do |f|
  f.name   'my_club_name'
end

describe Club do

  before(:all) do 
    Club.delete_all
    @club = Factory(:club)
  end
  
  it "should not be considered valid if name is missing" do
    @club.name = ''
    @club.should_not be_valid
  end

end
