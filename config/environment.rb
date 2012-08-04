# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rolemaster::Application.initialize!

Rails.logger = Logger.new(STDOUT)



if $0 == 'irb'
  require 'hirb'
  Hirb.enable
end

class Logger
  def banner parm
    debug '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    debug parm
    debug '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  end
end

  


