



class SwitchRequestMailer < ActionMailer::Base
  def request_switch(member_id,assignment_id)
    @requesting_member = Member.find(member_id)
    @assignment = Assignment.find(assignment_id)
    @member_currently_with_role = Member.find(@assignment.member_id)
    @role = Role.find(@assignment.role_id)
    @club = Club.find(@requesting_member.club_id)
    @meeting = Meeting.find(@assignment.meeting_id)
    mail(:to => @member_currently_with_role.email, :subject => "Role Switch Request", :from => "joe.meirow@gmail.com")  
  end
end