require 'custom/mailing_lists.rb'



class RoleSignupNotificationMailer < ActionMailer::Base
  
  include EmailConfig

  def member_signed_up_for_role(member_id,meeting_id,role_id)
    
      Rails.logger.info("INSIDE OF member_signed_up_for_role.................................................")

      @assignment = Assignment.where("meeting_id = ? and role_id = ?", meeting_id,role_id).first
      @member = Member.find(member_id)
      @role = Role.find(role_id)
      @club = Club.find(@member.club_id)
      @meeting = Meeting.find(meeting_id)

      @meeting_date = @meeting.meeting_date.strftime("%m/%d/%Y")
      mailing_lists = MailingLists.new 
      dist_list = mailing_lists.active_members(@club.id)
       
      mail(:to => dist_list, :subject => "Role Signup Notification", 
        :from => "joe.meirow@gmail.com")
     
  end
end
