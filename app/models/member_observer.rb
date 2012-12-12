require './lib/custom/active_audit.rb'
class MemberObserver < ActiveRecord::Observer
  include ActiveAudit
end