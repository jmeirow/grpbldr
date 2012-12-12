require './lib/custom/active_audit.rb'
class LeaderObserver < ActiveRecord::Observer
  include ActiveAudit
end