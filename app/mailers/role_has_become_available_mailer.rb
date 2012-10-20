require 'custom/mailing_lists.rb'



class RoleHasBecomeAvailableMailer < ActionMailer::Base
  
  include EmailConfig

  def role_has_become_available(meeting_id,role_id)

    @meeting = Meeting.find(meeting_id)
    @role = Role.find(role_id)
    @club = Club.find(@meeting.club_id)
    @meeting_date = @meeting.meeting_date.strftime("%m/%d/%Y")
    mailing_lists = MailingLists.new 
    dist_list = mailing_lists.active_members(@club.id,self)
     
    if dist_list.length > 0
      mail(:to => dist_list, :bcc => "joe.meirow@gmail.com" , :subject => "A Previously-filled Meeting Role Has Become Available", :from => "noreply@grpbldr.com")
    else
      mail(:to => "joe.meirow@gmail.com",                  :subject => "A Previously-filled Meeting Role Has Become Available (no members in dist list)", :from => "noreply@grpbldr.com")
    end

  end
end
