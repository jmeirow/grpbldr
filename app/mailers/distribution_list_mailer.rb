

class DistributionListMailer < ActionMailer::Base
  def relay(id, message)


   
  	email = Email.find(id)
  	 
	  @body = message.text_part.body.raw_source

	
	content_type = "text/plain"
	 
	# message.attachments.each do |attachment|
	# 	attachments[attachment.filename] = attachment.read
	# 	content_type = "multipart/mixed"
	# 	attachments[attachment.filename].content_type = attachment.content_type
	# 	attachments[attachment.filename].content_disposition = attachment.content_disposition
	# 	attachments[attachment.filename].content_transfer_encoding = attachment.content_transfer_encoding
	# end

	mail(	:from => email.from,
			:to => email.to, 
			:subject => email.subject, 
			:content_type => content_type)  

		

  end
end