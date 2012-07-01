class LoginMailer < ActionMailer::Base
  def member_logged_in(club_name, first_name, last_name)
  	@club_name = club_name
  	@first_name = first_name
  	@last_name = last_name
  	mail(:to => "joe.meirow@gmail.com", :subject => @first_name + ' ' + @last_name + " Has Logged In", :from => "joe.meirow@gmail.com" )  
  end
end