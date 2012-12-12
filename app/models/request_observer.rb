require './lib/custom/active_audit.rb'
class RequestObserver < ActiveRecord::Observer
  include ActiveAudit
end