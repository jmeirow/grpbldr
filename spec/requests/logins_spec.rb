# require 'spec_helper'
# require 'pp'


# puts ActiveRecord::Base.connection_config

# describe "GroupBuilder Session" do
#   describe "login" do
#     it "should find the login page" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       visit '/'
#       pp page
#       page.should have_content("Organizational Representatives")
#     end 
 

#     it "should fail to login as joe meirow" do
#       visit log_in_path
#       fill_in "email", :with => "joe.meirow@gmail.com"
#       fill_in "password", :with => "123456!!"
#       click_button "Sign In"
#       page.should have_content("Invalid email")
#     end


 
#   end

#   describe "Disabling Email" do

#     it "should login as joe meirow" do
#       visit log_in_path
#       fill_in "email", :with => "joe.meirow@gmail.com"
#       fill_in "password", :with => "123456!!"
#       click_button "Sign In"

#       page.should have_content("Upcoming Activity for Meirow, Joseph")
#       click_link("System Administration")
#       click_link("Revoke Super User")
#       click_link("Administration")
#       click_link("Club")
#       click_link("Edit")
#       choose("club_email_enabled_false")
#       click_button("Save")
#       page.should have_content("Automatic email notifications")
#       click_link("Log out")
#       page.should have_content("Logged out!")
      
#     end
#   end

 
# end

