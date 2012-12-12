require './lib/custom/active_audit.rb'
class LogObserver < ActiveRecord::Observer
  include ActiveAudit
end