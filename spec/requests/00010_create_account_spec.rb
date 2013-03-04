require 'spec_helper'
require 'pp'
require 'rspec/rspec_helpers.rb'

if ENV['RAILS_ENV'] !='production'
  require 'pry'
  require 'pry_debug'
end

RSpecHelpers.initialize_session

describe "When registing a new club/organization, the system " do

  include RSpecHelpers

  it " should display an error message when submitting the registration form without entering any data entered."  do
    visit log_in_path
    click_link('Register')
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
  end

  it "should give correct error messages when partial data entered."  do
    visit log_in_path
    click_link('Register')
    fill_in "enrollment_first_name", :with => "Joseph"
    click_button('Register')
    page.should have_content("prohibited this enrollment from")
    page.should_not have_content("First name can't be")
    #register the organization here....
    register_organization  
  end

  #and now log in...
  it " should log in when all information is provided" do
    visit log_in_path
    fill_in "email", :with => email
    fill_in "password", :with => password
    click_button "Sign In"
    page.should have_content("Logged in!")
  end

end