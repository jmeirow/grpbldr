require './lib/custom/active_audit.rb'
class LeaderHistoryObserver < ActiveRecord::Observer
  include ActiveAudit
end