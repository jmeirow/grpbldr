require "spec_helper"
require "pp"
require 'rspec/rspec_helpers.rb'


describe "When creating roles, "   do
  
  include RSpecHelpers
  
  it " descriptive information is required."  do
    login 
    click_link "Administration" 
    click_link "Roles" 
    click_link  "Create Role" 

    # try to save without entering data....
    click_button "Save Role"
    page.should have_content "Description can't be blank"


    click_link "Main Menu" 

    role_1_name  = "Role 1"
    create_role  role_1_name, 'Regular'

    role_1_found = false
    click_link "Roles" 

    all("tr").each do |row| 
      if /#{role_1_name}/.match(row.text)
        role_1_found = true
        break
      end
    end    
    role_1_found.should be_true

    click_link  "Main Menu" 
    role_2_name = "Role 2"
    create_role role_2_name, 'Officer'
    role_2_found = false
    click_link "Roles" 


    all("tr").each do |row| 
      if /Role 2/.match(row.text)
        role_2_found = true
        break
      end
    end    
    role_2_found.should be_true
  end
end




