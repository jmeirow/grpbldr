require './lib/custom/active_audit.rb'
class AgendaBottomObserver < ActiveRecord::Observer
  include ActiveAudit
end