
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


def reassign_io logfile, files
  first_time_files = Array.new
  ObjectSpace.each_object(File) do |f|
    first_time_files << f.path  if ( (!files.include?(f.path)) && ( f.path.end_with?('.log') ||  f.path.end_with?('.output') ))
  end
  first_time_files.each do |file|
      puts "Redicting io for #{file}"
      $stdout.reopen(logfile, "w")
  end
  files += first_time_files
  $stdout.sync = true
end

def config logfile, server
  Mailman.config.poll_interval = 3
  Mailman.config.logger = Logger.new File.open(logfile,"w")
  Mailman.config.ignore_stdin = true
  Mailman.config.pop3 = {
    :server           => server, 
    :port             => 995, 
    :ssl              => true,
    :username         => ENV['GB_RELAY_POP_USERNAME'],
    :password         => ENV['GB_RELAY_POP_PASSWORD']
  } unless Mailman.config.pop3
end

logfile = "#{Dir.pwd}/mailman_server.log"
server = ENV['GB_RELAY_POP_SERVER'].gsub(/"/,'')
files = Array.new
first_time = true

Daemons.run_proc('mailman.rb') do 
  if first_time
    first_time = false
    Mailman.config.logger.info "hey"
    first_time = false
    config logfile, server
    reassign_io  logfile, files
  end
  loop do 
    Mailman::Application.run do
      default do
        MailUtility.new.forward(message, params)
        puts "inside"
      end
    end
    puts "outside"
    sleep 2
  end
end























