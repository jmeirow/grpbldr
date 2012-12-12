require './lib/custom/active_audit.rb'
class RoleGroupObserver < ActiveRecord::Observer
  include ActiveAudit
end