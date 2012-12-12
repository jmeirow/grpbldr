require './lib/custom/active_audit.rb'
class MeetingNoteObserver < ActiveRecord::Observer
  include ActiveAudit
end