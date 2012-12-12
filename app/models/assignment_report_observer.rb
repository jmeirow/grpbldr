require './lib/custom/active_audit.rb'
class AssignmentReportObserver < ActiveRecord::Observer
  include ActiveAudit
end