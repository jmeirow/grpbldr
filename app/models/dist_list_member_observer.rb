require './lib/custom/active_audit.rb'
class DistListMemberObserver < ActiveRecord::Observer
  include ActiveAudit
end