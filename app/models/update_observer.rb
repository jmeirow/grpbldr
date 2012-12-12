require './lib/custom/active_audit.rb'
class UpdateObserver < ActiveRecord::Observer
  include ActiveAudit
end