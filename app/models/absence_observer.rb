require './lib/custom/active_audit.rb'
class AbsenceObserver < ActiveRecord::Observer
  include ActiveAudit
end