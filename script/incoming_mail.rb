require "#{ENV['GB_RAILS_ROOT']}/script/recipient_list.rb"
require "#{ENV['GB_RAILS_ROOT']}/script/outgoing_mail.rb"


class IncomingMail


  def initialize(message, params)
    # @user = User.where(email: message.from).first rescue nil
    @message = message
    @params = params
  end


  def process(method)
    #   if spam_test #### this is a good place to filter unwanted mail.
    self.send method
  end

 


  def recipient_list

  end

 
end