
require "rubygems"
require "bundler/setup"
require 'action_view'
require "#{ENV['GB_RAILS_ROOT']}/config/environment"
require "#{ENV['GB_RAILS_ROOT']}/script/mailman_server.rb"


MailmanServer.run
