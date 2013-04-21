require "#{ENV['GB_RAILS_ROOT']}/script/recipient_list.rb"
require "#{ENV['GB_RAILS_ROOT']}/lib/custom/system_services.rb"

 

class MailUtility

  include EmailConfig
  include ActionView::Helpers::TagHelper
  include SystemServices
 

  def self.GB_EMAIL_POLLING_DOMAIN
    "GB_EMAIL_POLLING_DOMAIN"
  end
  def self.RAILS_ENV
    "RAILS_ENV"
  end
  def self.GB_RELAY_POP_SERVER
    "GB_RELAY_POP_SERVER"
  end


	def forward message, params
    email = copy message 
    if email.to.length > 0
      email.save
      begin 
        relay_email(email.id, message) 
        email.delivered_ts = Time.now
        email.comments = "Sending message to relay_email service."
        email.save 
      rescue Exception => e 
        if email.id 
          email.comments = "   :::    " + e.message 
          email.save
          notify_sysadmin_email_failure   email
        else 
          puts "Message send failed - unable to save to database "
          pp email 
        end
      end
    else
      email.comments =  "Email not sent - empty recipient_list"
      email.save
    end
    puts "Message with subject = '#{email.subject}' was saved."
    puts "Total count of emails sent:  #{Email.count}"
	end
  

  def copy message 
    email = Email.new 
    email.to =   RecipientList.new(message.to).addresses
    email.cc =   RecipientList.new(message.cc).addresses if email.cc
    email.bcc =  RecipientList.new(message.bcc).addresses if email.bcc
    email.subject =  message.subject
    email.from = message.from.first
    email.body = message.text_part.body.raw_source
    email
  end

  def notify_sysadmin reason, *args
    if reason == :email_failure
      notify_sysadmin_email_failure *args
    end
  end

  def notify_sysadmin_email_failure failed_email
    email = Email.new
    email.to = "joe.meirow@gmail.com"
    email.subject = "GroupBuilder:  Email failure"
    email.body = "Email id #{failed_email.id} was not sent or was not delivered. Reason = #{failed_email.comments}."
    email.from = "joe.meirow@gmail.com"
    email.save
    send_email_to_sysadmin email.id 
  end

end

