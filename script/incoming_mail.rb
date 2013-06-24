require "#{ENV['GB_RAILS_ROOT']}/script/recipient_list.rb"
require "#{ENV['GB_RAILS_ROOT']}/script/outgoing_mail.rb"


class IncomingMail


  def initialize(message, params)
    @message = message
    @params = params
  end


  def process(method)
    self.send method
  end

 


  def recipient_list

  end

 
end