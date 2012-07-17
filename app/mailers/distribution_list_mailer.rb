

class DistributionListMailer < ActionMailer::Base
  def relay(id)
  	email = Email.find(id)
	@body = email.body
	mail(:from => email.from,:to => email.to, :subject => email.subject, :content_transfer_encoding => "quoted-printable", :content_type => "text/html")  
  end
end