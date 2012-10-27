require 'spec_helper'
require 'pp'


puts ActiveRecord::Base.connection_config

describe "GroupBuilder Session" do
 
  describe "Signing up for a Role" do

    it "should give an error message when signing up for a role and no checkbox clicked." do
      visit log_in_path
      fill_in "email", :with => "joe.meirow@gmail.com"
      fill_in "password", :with => "monie423"
      click_button "Sign In"
      page.should have_content("Upcoming Activity for Meirow, Joseph")    
      click_link('Sign Up')
      page.should have_content("Find a Meeting Role")
      click_button "Save Selection"
      page.should have_content("error prohibited")
    end

    it "should add a selected role to your upcoming activity.",  :driver => :selenium  do
      visit log_in_path
      fill_in "email", :with => "joe.meirow@gmail.com"
      fill_in "password", :with => "monie423"
      click_button "Sign In"
      page.should have_content("Upcoming Activity for Meirow, Joseph")    
    
      click



      click_link('Sign Up')
      page.should have_content("Find a Meeting Role")
          
      @date_before = find("td#date_1").text.split(' ')[0].rstrip
      @role_before = find("td#role_1").text.rstrip 


      find("td#cb_1").find("input[type='checkbox']").set(true)
      click_button "Save Selection" 
      page.should_not have_content("error prohibited")

      click_link("Upcoming Activity")

      found = false
     
      all('tr').each do |row| 
        if  row.text.index(@date_before).nil? == false && row.text.index(@role_before).nil? == false
          within(row) do
            click_link 'Remove'
            alert = page.driver.browser.switch_to.alert
            alert.accept
            alert = page.driver.browser.switch_to.alert
            alert.accept
           
          end
         found = true
        end

      end
      found.should be_true
     end
  end


 








end

