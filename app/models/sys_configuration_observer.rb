require './lib/custom/active_audit.rb'
class SysConfigurationObserver < ActiveRecord::Observer
  include ActiveAudit
end