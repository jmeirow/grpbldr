

class DistributionListMailer < ActionMailer::Base
  def relay(id)
  	email = Email.find(id)
	 	@body = email.body
		mail(:to => "joe.meirow@gmail.com", :subject => email.subject , :from => email.from )

  end
end