require 'spec_helper'
require 'pp'
require 'date'
require 'pry'
require 'pry_debug'

puts ActiveRecord::Base.connection_config

describe "GroupBuilder Session" do
 
  describe "Signing up for a Meeting" do

    it " a user session to create a meeting type."       do
      visit log_in_path
      fill_in "email", :with => "joe.meirow@gmail.com"
      fill_in "password", :with => "123456!!"
      click_button "Sign In"
      page.should have_content("Upcoming Activity for Meirow, Joseph")    
      


      click_link('Administration')
      click_link('Meeting Types')
      click_link('New Meeting Type')
      


      page.should have_content("New Meeting Type")
      


      meeting_time = "10:30 AM"
      meeting_type_name = "Officer"
      fill_in "meeting_type_description", :with => meeting_type_name
      #binding.pry

      fill_in "meeting_type_meeting_time", :with => meeting_time
      #binding.pry
      click_button "Save Meeting Type"
      #binding.pry
 
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
 end

