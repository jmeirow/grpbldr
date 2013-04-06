





require "#{ENV['GB_RAILS_ROOT']}/lib/custom/string_helper.rb"
require "#{ENV['GB_RAILS_ROOT']}/lib/custom/mailing_lists.rb"
require "#{ENV['GB_RAILS_ROOT']}/lib/custom/system_services.rb"
require "#{ENV['GB_RAILS_ROOT']}/app/models/email.rb"
require "#{ENV['GB_RAILS_ROOT']}/script/recipient_list.rb"
require "#{ENV['GB_RAILS_ROOT']}/script/mail_utility.rb"

class MailmanServer

  def self.run 

    ENV[MailUtility.RAILS_ENV] ||= "development"
    #require File.dirname(__FILE__) + "/../config/environment"

    ENV[MailUtility.GB_EMAIL_POLLING_DOMAIN]  ||= "@gmail.com"


    Mailman.config.ignore_stdin = true
    Mailman.config.logger = Logger.new File.expand_path("../../log/mailman_#{ENV["RAILS_ENV"]}.log", __FILE__)

    if ENV[MailUtility.RAILS_ENV] == 'test'
      Mailman.config.maildir = File.expand_path("../../tmp/test_maildir", __FILE__)
    else
      Mailman.config.logger = Logger.new "#{ENV['GB_RAILS_ROOT']}/log/mailman_#{ENV['RAILS_ENV']}.log"
      Mailman.config.poll_interval = 2
      Mailman.config.pop3 = {
        :server     =>  ENV['GB_RELAY_POP_SERVER'], 
        :port       =>  995, 
        :ssl        =>  true,
        :username   =>  ENV['GB_RELAY_POP_USERNAME'],
        :password   =>  ENV['GB_RELAY_POP_PASSWORD']
      }
    end

    Mailman::Application.run do
      to('') do
        begin
          MailUtility.new.forward(message, params)
        rescue Exception => e 
          puts e.message 
          puts e.backtrace
        end
      end
    end
  end

end