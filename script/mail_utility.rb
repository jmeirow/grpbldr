
# require "#{ENV['GB_RAILS_ROOT']}/config/environment"

require 'active_record'
require 'action_mailer'
require "#{ENV['GB_RAILS_ROOT']}/app/models/email.rb"

require "#{ENV['GB_RAILS_ROOT']}/script/recipient_list.rb"
require "#{ENV['GB_RAILS_ROOT']}/lib/custom/system_services.rb"
require "#{ENV['GB_RAILS_ROOT']}/app/models/sys_configuration.rb"

class MailUtility

  def initialize

    Mailman.config.ignore_stdin = true
  end

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

    if message.to.length > 0
      email = copy (message) 
      email.save
      relay_email(email.id, message) 
      email.delivered_ts = Time.now
      email.save 
    else
      email = copy message 
      email.comments =  "Email not sent - empty recipient_list"
      email.save
    end
  end
  

  def copy message 

    if ActiveRecord::Base.retrieve_connection
      
      ActiveRecord::Base.remove_connection
    end
    
    ActiveRecord::Base.establish_connection(
      adapter: "postgresql",
      database: "grpbldr_#{ENV['RAILS_ENV']}" ,
      encoding: "unicode" ,
      username: "postgres",
      password:  ENV['GB_APP_DB_PASSWORD'],
      host: "localhost"
    )

    email = Email.new 
    email.from  = message.from
    email.to =   RecipientList.new(message.to).addresses
    email.cc =   RecipientList.new(message.cc).addresses if email.cc
    email.bcc =  RecipientList.new(message.bcc).addresses if email.bcc
    email.subject =  message.subject
    email.from = message.from.first
    email.body = message.text_part.body.raw_source
    email
  end

 
  def heartbeat_no_mailman
    util = MailUtility.new
    email = Email.new
    email.subject = "GroupBuilder: Email daemon not found!"
    email.to = "joe.meirow@gmail.com"
    email.body = "Email daemon not found."
    email.save
    util.notify_sysadmin_email_failure   email.id
  end

  def notify_sysadmin_email_failure failed_email
    util = MailUtility.new
    email = Email.new
    email.to = "joe.meirow@gmail.com"
    email.subject = "GroupBuilder:  Email failure"
    email.body = "Email id #{failed_email.id} was not sent or was not delivered. Reason = #{failed_email.comments}."
    email.from = "joe.meirow@gmail.com"
    email.save
    util.send_email_to_sysadmin email.id 
  end


end




