require './lib/custom/active_audit.rb'
 


class MeetingTypeObserver < ActiveRecord::Observer
  include ActiveAudit

  def before_update(observed)
    agenda = AgendaDefinition.where("meeting_type_id = ?", observed.id).first
    agenda.name = observed.description
    agenda.save
  end


end