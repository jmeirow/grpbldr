# require 'spec_helper'
# require 'pp'


# puts ActiveRecord::Base.connection_config

# describe "GroupBuilder Session" do
#   describe "Signing up for a Role" do
#     it "should show only roles that match the role used in the filter.",  :driver => :selenium  do
#       visit log_in_path
#       fill_in "email", :with => "joe.meirow@gmail.com"
#       fill_in "password", :with => "monie423"
#       click_button "Sign In"
#       page.should have_content("Upcoming Activity for Meirow, Joseph")    
#       click_link('Sign Up')
#       page.should have_content("Find a Meeting Role")
#       select('Ah-Counter', :from => 'role_role_id')
     
#       all('tr').each do |row| 
#         within(row) do
#            # all('td').each do |cell|
#            #  within(cell) do 
#            #    find
#           puts "testing that every row has 'Ah-Couner'"
#           if row[:id].match(/row_/)
#           	row.text.should match(/Ah-Counter/)
#           end
#         end
#       end
#      end
#   end
# end

