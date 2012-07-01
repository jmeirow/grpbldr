require 'custom/mailing_lists.rb'
require 'email_config.rb'


class RoleSignupNotificationMailer < ActionMailer::Base
  
  include EmailConfig

  def member_signed_up_for_role(member,assignment)
    

      
      
      @requesting_member = member
      @first_name = member.first_name
      @last_name = member.last_name
      @assignment = assignment
      @role = Role.find(@assignment.role_id)
      @role_description = @role.description
      @club = Club.find(@requesting_member.club_id)
      @club_name = @club.name
      @meeting = Meeting.find(@assignment.meeting_id)
      @meeting_date = @meeting.meeting_date.strftime("%m/%d/%Y")
      mailing_lists = MailingLists.new 
      dist_list = mailing_lists.active_members(@club.id)
       
      mail(:to => dist_list, :subject => "Role Signup Notification", 
        :from => "joe.meirow@gmail.com")
     
  end
end
