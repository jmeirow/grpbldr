require './lib/custom/active_audit.rb'
class AssignmentObserver < ActiveRecord::Observer
  include ActiveAudit
end