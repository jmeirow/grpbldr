require './lib/custom/active_audit.rb'
class AgendaDefinitionObserver < ActiveRecord::Observer
  include ActiveAudit
end