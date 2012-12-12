require './lib/custom/active_audit.rb'
class NotificationTypeObserver < ActiveRecord::Observer
  include ActiveAudit
end