require 'custom/mailing_lists.rb'



class RoleHasBecomeAvailableMailer < ActionMailer::Base
  
  include EmailConfig

  def role_has_become_available(meeting_id,role_id)
    
     
      @meeting = Meeting.find(meeting_id)
      @role = Role.find(role_id)
      @club = Club.find(@meeting.club_id)
      @meeting_date = @meeting.meeting_date.strftime("%m/%d/%Y")
      mailing_lists = MailingLists.new 
      dist_list = mailing_lists.active_members(@club.id)
       
      mail(:to => dist_list, :subject => "A Previously-filled Meeting Role Has Become Available", 
        :from => "joe.meirow@gmail.com")
     
  end
end
