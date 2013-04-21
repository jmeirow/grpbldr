require 'pp'

class DistributionListMailer < ActionMailer::Base
  
  def relay(id, message)
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