require 'date'
require "spec_helper"
require "pp"
require 'rspec/rspec_helpers.rb'

 
include RSpecHelpers


describe "GroupBuilder Session" do
 
  describe "Creating a REGULAR meeting  " do

    it " a user session creating a meeting." ,  :driver => RSpecHelpers.testing_driver  do
      login
      
      

      click_link('Meetings')
      
      

      click_link 'New Meeting'
      click_button "Save Meeting"

      page.should have_content("Meeting date is required")
       

      meeting_date = (Date.today+7).strftime("%m/%d/%Y")

      fill_in "meeting_meeting_date_display", :with => meeting_date
      
      click_button "Save Meeting"
      
      page.should have_content("successfully created.")
      page.should have_content(meeting_date)


      click_link "Log out"
    end
  end

describe "Creating an OFFICER Meeting" do

    it " a user session creating a meeting.",  :driver => RSpecHelpers.testing_driver  do
      login
      page.should have_content("Upcoming Activity for Meirow, Joseph")    
      

      click_link('Meetings')
      page.should have_content("Meetings for SpeakEasy Toastmasters")
      

      click_link 'New Meeting'
      click_button "Save Meeting"

      page.should have_content("Meeting date is required")
       

      meeting_date = (Date.today+14).strftime("%m/%d/%Y")

      fill_in "meeting_meeting_date_display", :with => meeting_date
      
      page.select('Officer', :from => 'meeting_meeting_type_id')

      click_button "Save Meeting"
      page.should have_content("successfully created.")


      click_link('Meetings')
      page.should have_content(meeting_date)
 
      
    end
  end



 end

