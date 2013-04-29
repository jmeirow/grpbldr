require 'pp'
require 'pry'
require 'pry_debug'


class DistributionListMailer < ActionMailer::Base

  def relay(id, message)
 

    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
       :address   => ENV['GB_SMTP_ADDRESS'],
       :port      => 587,
       :domain    =>  ENV['GB_SMTP_DOMAIN'],
       :authentication => :plain,
       :user_name      => ENV['GB_SMTP_USER_NAME'],
       :password       => ENV['GB_SMTP_PASSWORD'],
       :enable_starttls_auto => true
      }
     ActionMailer::Base.view_paths= "#{ENV['GB_RAILS_ROOT']}/app/views/distribution_list_mailer"

     
    email = Email.find(id)
  	@body = message.text_part.body
    content_type = "text/plain"

    # message.attachments.each do | attachment |
    #   File.open(attachment.filename,"w") do |f|
    #     f.write(attachment.read)
    #   end
    #   attachments[attachment.filename] = File.read(attachment.filename)
    # end

    mail( :from => email.from, 
          :to => email.to, 
          :cc => email.cc, 
          :bcc => email.bcc, 
          :subject => email.subject, 
          :content_type => content_type)
  end



  def send_to_sysadmin id
    email = Email.find(id)
    @body = email.body
    content_type = "text/plain"
    mail( :from => email.from, 
          :to => email.to, 
          :subject => email.subject, 
          :content_type => content_type,
          :layout => 'relay')

  end

end