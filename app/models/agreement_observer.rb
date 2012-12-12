require './lib/custom/active_audit.rb'
class AgreementObserver < ActiveRecord::Observer
  include ActiveAudit
end