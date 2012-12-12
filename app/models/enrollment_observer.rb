require './lib/custom/active_audit.rb'
class EnrollmentObserver < ActiveRecord::Observer
  include ActiveAudit
end