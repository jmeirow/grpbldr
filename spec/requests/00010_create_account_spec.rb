require 'spec_helper'
require 'pp'
 
describe "Registering a club " do

  it "should give an error message if no data entered."  do
    visit log_in_path
    click_link('Register')
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
  end



  it "should give correct error messages when partial data entered."   do
    visit log_in_path
    click_link('Register')
    fill_in "enrollment_first_name", :with => "Joseph"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should_not have_content("First name can't be")


    fill_in "enrollment_last_name", :with => "Meirow"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should_not have_content("Last name can't be")


    fill_in "enrollment_club_name", :with => "SpeakEasy Toastmasters of Shelby Township"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should_not have_content("Club name can't be")


    fill_in "enrollment_email", :with => "joe"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should have_content("Email is invalid")


    fill_in "enrollment_email", :with => "joe."
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should have_content("Email is invalid")

    fill_in "enrollment_email", :with => "joe.meirow"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should have_content("Email is invalid")


    fill_in "enrollment_email", :with => "joe.meirow@"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should have_content("Email is invalid")

    fill_in "enrollment_email", :with => "joe.meirow@gmail"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should have_content("Email is invalid")

    fill_in "enrollment_email", :with => "joe.meirow@gmail."
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should have_content("Email is invalid")

    fill_in "enrollment_email", :with => "joe.meirow@gmail.com"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should_not have_content("Email is invalid")


    fill_in "enrollment_password", :with => "123456!!"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should_not have_content("Password can't be blank")


    fill_in "enrollment_password", :with => "123456!!"
    fill_in "enrollment_password_confirmation", :with => "xxxx"
    click_button('Register')
    page.should have_content("Password doesn't match confirmation")

   
    fill_in "enrollment_password", :with => "123456!!"
    fill_in "enrollment_password_confirmation", :with => "123456!!"
    click_button('Register')
    page.should have_content("Enrollment complete!")
  end


  it "should login as joe meirow" do
    visit log_in_path
    fill_in "email", :with => "joe.meirow@gmail.com"
    fill_in "password", :with => "123456!!"
    click_button "Sign In"
  end

end