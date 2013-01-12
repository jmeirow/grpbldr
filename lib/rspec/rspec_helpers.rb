module   RSpecHelpers


  def self.initialize_session
    Thread.current[:email] = "joe.meirow@gmail.com"
    Thread.current[:password] = "monie423!!"
    Thread.current[:driver] = :webkit
  end

  def self.testing_driver
    Thread.current[:driver]
  end

  def email
    Thread.current[:email]
  end

  def password
    Thread.current[:password]
  end

  def login  
    visit log_in_path
    fill_in "email", :with => email
    fill_in "password", :with => password
    click_button "Sign In"
  end


  def  register_organization  
    visit log_in_path
    click_link('Register')
    fill_in "enrollment_first_name", :with => "Joseph"
    fill_in "enrollment_last_name", :with => "Meirow"
    fill_in "enrollment_club_name", :with => "SpeakEasy Toastmasters of Shelby Township"
    fill_in "enrollment_email", :with => email
    fill_in "enrollment_password", :with => password
    fill_in "enrollment_password_confirmation", :with => password
    click_button('Register')
  end

  def create_meeting_type
  end

  def create_role  role_name
    click_link "Administration"  
    click_link "Roles"  
    click_link "Create Role"  
    fill_in "role_description", :with => role_name
    click_button "Save Role" 
  end
  def create_memeber
  end
  def create_role_group
  end
  def create_role_meeting_type
  end

end
