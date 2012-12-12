require 'date'
require "spec_helper"
require "pp"
require 'rspec/rspec_helpers.rb'
require "pry"
require "pry_debug"
 
include RSpecHelpers


describe "GroupBuilder Session" do
 
  describe "Signing up for a Meeting" do

    it " a user session creating a meeting.",  :driver => RSpecHelpers.testing_driver  do
      login
      page.should have_content("Upcoming Activity for Meirow, Joseph")    
      
      puts "-----------------   1"

      click_link('Meetings')
      page.should have_content("Meetings for SpeakEasy Toastmasters")
      
      puts "-----------------   2"

       click_link 'New Meeting'
       click_button "Save Meeting"

      page.should have_content("Meeting date is required")
       
      puts "-----------------   3"

      meeting_date = (Date.today+7).strftime("%m/%d/%Y")

      fill_in "meeting_meeting_date_display", :with => meeting_date
      click_button "Save Meeting"
      page.should have_content("successfully created.")
      puts "-----------------   4"


      click_link('Meetings')
      
 
      found = false
      puts "-----------------   5"
     
      all('tr').each do |row| 
        if  row.text.index(meeting_date).nil? == false  
          if row.text.index(meeting_date)
            found = true
            break
          end
        end
      end
      puts "-----------------   6"
      found.should be_true
    end
  end
 end

