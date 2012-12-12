require './lib/custom/active_audit.rb'
class UserObserver < ActiveRecord::Observer
  include ActiveAudit
end