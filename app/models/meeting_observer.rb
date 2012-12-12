require './lib/custom/active_audit.rb'
class MeetingObserver < ActiveRecord::Observer
  include ActiveAudit
end