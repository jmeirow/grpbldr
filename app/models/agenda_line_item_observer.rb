require './lib/custom/active_audit.rb'
class AgendaLineItemObserver < ActiveRecord::Observer
  include ActiveAudit
end