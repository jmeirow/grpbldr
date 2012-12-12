require './lib/custom/active_audit.rb'
class MemberNotificationPreferenceObserver < ActiveRecord::Observer
  include ActiveAudit
end