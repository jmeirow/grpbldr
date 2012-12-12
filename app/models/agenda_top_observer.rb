require './lib/custom/active_audit.rb'
class AgendaTopObserver < ActiveRecord::Observer
  include ActiveAudit
end