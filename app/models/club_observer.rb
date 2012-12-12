require './lib/custom/active_audit.rb'
class ClubObserver < ActiveRecord::Observer
  include ActiveAudit
end