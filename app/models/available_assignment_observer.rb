require './lib/custom/active_audit.rb'
class AvailableAssignmentObserver < ActiveRecord::Observer
  include ActiveAudit
end