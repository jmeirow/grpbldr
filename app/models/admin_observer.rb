require './lib/custom/active_audit.rb'
class AdminObserver < ActiveRecord::Observer
  include ActiveAudit
end