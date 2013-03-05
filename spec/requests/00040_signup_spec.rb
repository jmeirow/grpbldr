require 'date'
require "spec_helper"
require "pp"
require 'rspec/rspec_helpers.rb'
 
include RSpecHelpers




describe "Insure that whenever meetings are added, they pick up existing roles for that meeting type" do

  it " should appear on all future meetings of that type (Regular) and only on meetings of that type."  ,  :driver => RSpecHelpers.testing_driver  do


    role_1_name = 'Role 1'
    role_2_name = 'Role 2'
   

    login    # Log in to the site
    
    


    puts "The meeting sign up page defaults to the 'Regular' meeting and at this point in the test should only show 'Role 1'. 
    'Role 2' is associated with the 'Officer' meeting type and therefore should not display when first arriving on the page "

      click_link('Sign Up')

     



      puts "Check roles for 'Regular' meeting type."

      page.should have_content "Find a Meeting Role"
      
      page.should have_content role_1_name
      page.should_not have_content  role_2_name

     





      puts "Check roles for 'Regular' meeting type."
      
      page.select('Officer', :from => 'meeting_type_id')

      page.should_not have_content "Role 1"
      page.should have_content "Role 2"
    




    
      puts "Create a new role, 'Role 3' and associate it with 'Regular' meeting type."

      role_3_name  = "Role 3"
      create_role  role_3_name, 'Regular'

      role_3_found = false
      click_link "Roles" 

      all("tr").each do |row| 
        if /#{role_3_name}/.match(row.text)
          role_3_found = true
          break
        end
      end    
      role_3_found.should be_true
 

      click_link "Main Menu" 

      puts "Create a new role, 'Role 4' and associate it with 'Officer' meeting type."

      role_4_name = "Role 4"
      create_role  role_4_name, 'Officer'
      role_4_found = false
      
      click_link "Roles" 


      all("tr").each do |row| 
        if /Role 4/.match(row.text)
          role_4_found = true
          break
        end
      end    
      role_4_found.should be_true
   




      puts "Check roles for 'Regular' meeting type. It should now have Roles 1 and 3 but not 2 or 4."
      
      click_link "Main Menu" 
      click_link('Sign Up')
    
      page.should have_content "Role 1"
      page.should_not have_content "Role 2"

      page.should have_content "Role 3"
      page.should_not have_content "Role 4"







      page.select('Officer', :from => 'meeting_type_id')
      
      page.should_not have_content "Role 1"
      page.should have_content "Role 2"


      page.should_not have_content "Role 3"
      page.should have_content "Role 4"





    
      


      # set up date variables...

      meeting_1_date = (Date.today+7).strftime("%m/%d/%Y")
      meeting_2_date = (Date.today+14).strftime("%m/%d/%Y")
      meeting_3_date = (Date.today+21).strftime("%m/%d/%Y")
      meeting_4_date = (Date.today+28).strftime("%m/%d/%Y")




      puts "now add two new meetings, one of each type. The Regular meeting should automatically pick up roles 1 and 3,
      and the Officer meeting roles 2 and 4."

      click_link('Meetings')
      click_link 'New Meeting'

      fill_in "meeting_meeting_date_display", :with => meeting_3_date
      click_button "Save Meeting"
      
      page.should have_content("successfully created.")
      page.should have_content(meeting_3_date)



      click_link('Meetings')
      click_link 'New Meeting'
 
       

      fill_in "meeting_meeting_date_display", :with => meeting_4_date
      page.select('Officer', :from => 'meeting_meeting_type_id')

      click_button "Save Meeting"
      page.should have_content("successfully created.")


      click_link('Sign Up')

      role_1_found = false
      role_2_found = false
      role_3_found = false
      role_4_found = false


    
      all("tr").each do |row| 
        if /#{role_1_name}/.match(row.text) && /#{meeting_1_date}/.match(row.text)
          role_1_found = true
        end
        if /#{role_3_name}/.match(row.text) && /#{meeting_3_date}/.match(row.text)
          role_3_found = true
        end        
        if /#{role_2_name}/.match(row.text) 
          role_2_found = true
        end  
        if /#{role_4_name}/.match(row.text) 
          role_4_found = true
        end  
      end    

      role_1_found.should be_true
      role_2_found.should be_false
     
      role_3_found.should be_true
      role_4_found.should be_false

      click_link('Sign Up')


      page.select('Officer', :from => 'meeting_type_id')
     

      role_1_found = false
      role_2_found = false
      role_3_found = false
      role_4_found = false


      
      # insure the each meeting has the right date for that meeting
      all("tr").each do |row| 
        if /#{role_2_name}/.match(row.text) && /#{meeting_2_date}/.match(row.text)
          role_2_found = true
        end
        if /#{role_4_name}/.match(row.text) && /#{meeting_4_date}/.match(row.text)
          role_4_found = true
        end        
        if /#{role_1_name}/.match(row.text) 
          role_1_found = true
        end  
        if /#{role_3_name}/.match(row.text) 
          role_3_found = true
        end  
      end    
  
      role_1_found.should be_false
      role_2_found.should be_true

      role_3_found.should be_false
      role_4_found.should be_true
  end
end

 














