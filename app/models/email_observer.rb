require './lib/custom/active_audit.rb'
class EmailObserver < ActiveRecord::Observer
  include ActiveAudit
end