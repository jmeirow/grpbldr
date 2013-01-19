require './lib/custom/active_audit.rb'
require 'pry'
require 'pry_debug'



class RoleMeetingTypeObserver < ActiveRecord::Observer
  include ActiveAudit

 

  def after_destroy observed
    Meeting.where("meeting_type_id = ? and meeting_date >= ?", observed.meeting_type_id, Date.today).each do |meeting|
      meeting.remove_from_available_roles Role.find(observed.role_id)
      meeting.save
    end
  end

  def after_create observed
    Meeting.where("meeting_type_id = ? and meeting_date >= ?", observed.meeting_type_id, Date.today).each do |meeting|
      meeting.add_to_available_roles Role.find(observed.role_id)
      meeting.save
    end
  end
 


end