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
    relay_email(email.id, message) 
	end


  def copy message 
    email = Email.new 
    email.to =  RecipientList.new(message.to).addresses
    email.subject =  message.subject
    email.from = message.from.first
    email.body = message.text_part.body  
    email.save
    email
  end


end

