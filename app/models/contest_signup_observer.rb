require './lib/custom/active_audit.rb'
class ContestSignupObserver < ActiveRecord::Observer
  include ActiveAudit
end