require './lib/custom/active_audit.rb'



class RoleMeetingTypeObserver < ActiveRecord::Observer
  include ActiveAudit

 
  # event handlers go here and calls are dispatech to all interested parties listed below

  
  def after_destroy observed
    delete_role_for_meeting_type_to_existing_meetings observed
  end

  def after_create observed
    add_new_role_for_meeting_type_to_existing_meetings observed
  end







  #other models define their 'care-abouts' here for this model's events

  def add_new_role_for_meeting_type_to_existing_meetings observed
     Meeting.where("meeting_type_id = ? and meeting_date >= ?", observed.meeting_type_id, Date.today).each do |meeting|
      meeting.add_to_available_roles Role.find(observed.role_id)
      meeting.save
    end
  end

  def delete_role_for_meeting_type_to_existing_meetings observed
    Meeting.where("meeting_type_id = ? and meeting_date >= ?", observed.meeting_type_id, Date.today).each do |meeting|
      meeting.remove_from_available_roles Role.find(observed.role_id)
      meeting.save
    end
  end

end