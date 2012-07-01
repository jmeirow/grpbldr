require 'custom/test_email_worker.rb'
require 'custom/mailing_lists.rb'


class TestController < ApplicationController
  def email
 


    
      worker = TestEmailWorker.new
      #worker.configure_smtp(SmtpConfig.new)
      mailing_list = MailingLists.new

      worker.info(mailing_list.active_members(2))
      worker.queue


    redirect_to club_member_assignments_path(current_club,current_member), :notice => "Sent"
  end
end
