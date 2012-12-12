require './lib/custom/active_audit.rb'
class EventObserver < ActiveRecord::Observer
  include ActiveAudit
end