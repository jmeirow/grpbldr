require 'date'
require "spec_helper"
require "pp"
require 'rspec/rspec_helpers.rb'


include RSpecHelpers

 
  describe "When signing up for a meeting, " do

    it " a user session to create a meeting type."  do
      login
      page.should have_content("Upcoming Activity for Meirow, Joseph")    
      
      click_link('Administration')
      click_link('Meeting Types')
      click_link('New Meeting Type')

      page.should have_content("New Meeting Type")

      meeting_time = "10:00 AM"
      meeting_type_name = "Officer"
      fill_in "meeting_type_description", :with => meeting_type_name

      fill_in "meeting_type_meeting_time", :with => meeting_time
      click_button "Save Meeting Type"
 
      found = false
     
      all('tr').each do |row| 
        if  row.text.index(meeting_type_name).nil? == false && row.text.index(meeting_time).nil? == false
          found = true
          break
        end
      end
      found.should be_true
    end
  end

