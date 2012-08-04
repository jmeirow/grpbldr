

class RoleHasBecomeAvailableMailerWorker

  include Sidekiq::Worker

  def perform(meeting_id,role_id)
    RoleHasBecomeAvailableMailer.role_has_become_available(meeting_id,role_id).deliver
  end


end
