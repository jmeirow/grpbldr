require './lib/custom/active_audit.rb'
class RoleObserver < ActiveRecord::Observer
  include ActiveAudit
end