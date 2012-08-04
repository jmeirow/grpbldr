
class LoginMailer < ActionMailer::Base
	
  # def member_logged_in(*args)

  	 
  # 	@member = Member.find(args[0])
  # 	@club = Club.find(@member.club_id)
  def member_logged_in(member_id)
   	member = Member.find(member_id)
  	club = Club.find(member.club_id)
    @member, @club = member, club
 	  mail(:to => "joe.meirow@gmail.com", :subject => member.first_name + ' ' + member.last_name + " Has Logged In", :from => "joe.meirow@gmail.com" )  
  end
end



