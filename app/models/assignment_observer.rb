require './lib/custom/active_audit.rb'
require 'pry'
require 'pry_debug'



class AssignmentObserver < ActiveRecord::Observer
  include ActiveAudit

  def before_destroy observed
    
  end

  def after_destroy observed
    meeting = Meeting.find(observed.meeting_id)
    meeting.add_to_available_roles Role.find(observed.role_id)
    meeting.save
  end

  def after_create observed
    meeting = Meeting.find(observed.meeting_id)
    meeting.remove_from_available_roles Role.find(observed.role_id)
    meeting.save
  end


end