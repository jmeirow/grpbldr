require './lib/custom/active_audit.rb'
class RoleGroupAssociationObserver < ActiveRecord::Observer
  include ActiveAudit
end