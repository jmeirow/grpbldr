class MemberMailer < ActionMailer::Base
  def member_added(member,club)
  	@member = member;
  	@club = club
    mail(:to => "joe.meirow@gmail.com", :subject => "Registered", :from => "joe.meirow@gmail.com" )  
  end
end