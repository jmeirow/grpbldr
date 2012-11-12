require 'spec_helper'
require 'pp'
require 'date'
require 'pry'
require 'pry_debug'

puts ActiveRecord::Base.connection_config

describe "GroupBuilder Session" do
 
  describe "Signing up for a Meeting" do

    it " a user session creating a meeting."   do
      visit log_in_path
      fill_in "email", :with => "joe.meirow@gmail.com"
      fill_in "password", :with => "123456!!"
      click_button "Sign In"
      page.should have_content("Upcoming Activity for Meirow, Joseph")    
      
      puts "-----------------   1"

      click_link('Meetings')
      page.should have_content("Meetings for SpeakEasy Toastmasters")
      
      puts "-----------------   2"

       click_link 'New Meeting'
       click_button "Save Meeting"

       #page.should have_content("Meeting date is required")
       
      puts "-----------------   3"

      meeting_date = (Date.today+7) 

      fill_in "meeting_meeting_date_display", :with => meeting_date
      click_button "Save Meeting"
      page.should have_content("Meeting for #{meeting_date.strftime("%m/%d/%Y")} was successfully created.")

      puts "-----------------   4"


      click_link('Meetings')
      
 
      found = false
      puts "-----------------   5"
     
      all('tr').each do |row| 
        if  row.text.index(meeting_date.strftime("%m/%d/%Y")).nil? == false  
          if row.text.index(meeting_date.strftime("%m/%d/%Y"))
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

