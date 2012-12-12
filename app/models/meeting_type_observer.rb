require './lib/custom/active_audit.rb'
class MeetingTypeObserver < ActiveRecord::Observer
  include ActiveAudit
end