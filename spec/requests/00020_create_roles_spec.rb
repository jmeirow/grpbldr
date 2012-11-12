require "spec_helper"
require "pp"
 
describe "A user session to create roles "   do
  

  it "should require the user to log in"      do
    
    visit log_in_path
    fill_in "email", :with => "joe.meirow@gmail.com"
    fill_in "password", :with => "123456!!"
    click_button "Sign In"
 

 
    page.should have_content  "Upcoming Activity"     

  


    click_link "Administration"  
    click_link "Roles"  
    click_link "New Role"  


    role_name = "Role example number 1"

    fill_in "role_description", :with => role_name
    click_button "Save Role" 
    page.should have_content "Role was successfully created."  


    click_link "Roles"  

 
    role_1_found = false

    all("tr").each do |row| 
      within(row) do
        if /#{role_name}/.match(row.text)
          role_1_found = true
        end
      end
    end    
    role_1_found.should be_true

    click_link "Main Menu" 

    click_link "Administration" 
    click_link "Roles" 
    click_link  "New Role" 
    click_button "Save Role"
    page.should have_content "Description can't be blank"


    role_name = "Role example number 2"

    fill_in "role_description", :with => role_name
    click_button "Save Role" 
    page.should have_content "Role was successfully created."  

    


  end


























end