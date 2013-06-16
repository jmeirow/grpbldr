#!/usr/bin/env ruby


require 'rubygems'
require "bundler/setup"
require 'daemons'
require "#{ENV['GB_RAILS_ROOT']}/config/environment"
require 'pp'

env_dir = "#{ENV['GB_RAILS_ROOT']}/script"
log_dir = "#{ENV['GB_RAILS_ROOT']}/log"
env_file = "#{env_dir}/.env"


options = {
  :app_name => 'mailman_server',
  :dir_mode => :normal,
  :dir =>  "#{Dir.pwd}",
  :log_output => true,
  :ARGV => [ ARGV[0], "--", "#{Dir.pwd}" ]
}



File.open(".env", "w") do |f|
  ENV.keys.select {|x| /^GB_/.match x }.each do |key|
    f.puts "#{key},#{ENV[key]}"
  end
end



Daemons.run('script/mailman_server', options) 