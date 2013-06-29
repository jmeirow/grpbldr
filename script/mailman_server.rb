
require 'rubygems'
require 'bundler/setup'
require "mailman"
require 'yaml'
require 'pp'


require "#{ENV['GB_RAILS_ROOT']}/config/environment"
require "#{ENV['GB_RAILS_ROOT']}/lib/custom/string_helper.rb"
require "#{ENV['GB_RAILS_ROOT']}/lib/custom/mailing_lists.rb"
require "#{ENV['GB_RAILS_ROOT']}/app/models/email.rb"
require "#{ENV['GB_RAILS_ROOT']}/script/recipient_list.rb"
require "#{ENV['GB_RAILS_ROOT']}/script/mail_utility.rb"

 

logfile = "#{Dir.pwd}/mailman_server.log"
server = ENV['GB_RELAY_POP_SERVER'].gsub(/"/,'')
files = Array.new
first_time = true




def config logfile, server
  Mailman.config.logger = Logger.new File.open(logfile,"w")
  Mailman.config.ignore_stdin = true
  Mailman.config.graceful_death = true
end


def login server
  Mailman.config.pop3 = {
  :server           => server, 
  :port             => 995, 
  :ssl              => true,
  :username         => ENV['GB_RELAY_POP_USERNAME'],
  :password         => ENV['GB_RELAY_POP_PASSWORD']
} unless Mailman.config.pop3
end


def reassign_io logfile, files
  first_time_files = Array.new
  ObjectSpace.each_object(File) do |f|
    first_time_files << f.path  if ( (!files.include?(f.path)) && ( f.path.end_with?('.log') ||  f.path.end_with?('.output')) && (!f.path.include? 'development.log') )
  end
  first_time_files.each do |file|
      puts "Redicting io for #{file}"
      $stdout.reopen(logfile, "w")
  end
  files += first_time_files
  $stdout.sync = true
end


config logfile, server

Daemons.run_proc('mailman.rb') do 

  reassign_io  logfile, files

  loop do
    sleep 2
    login server
    Mailman::Application.run do
      sleep 2
      default do
        MailUtility.new.forward(message, params)
      end
    end
    Mailman.config.pop3.disconnect
    sleep 2
  end
end



