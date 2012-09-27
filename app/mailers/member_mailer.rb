



class MemberMailer < ActionMailer::Base
  def member_added(member,club,admin)
  	@member = member;
  	@club = club
    @admin = admin
    mail(:to => member.email,  :bcc => "joe.meirow@gmail.com", :subject => "You've been added as a member of #{club.name} on GroupBuilder", :from => admin.email )  
  end
end