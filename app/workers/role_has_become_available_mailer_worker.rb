

class RoleHasBecomeAvailableMailerWorker

  include Sidekiq::Worker

  def perform(*args)
    meeting_id = args[0]
    role_id = args[1]
    RoleHasBecomeAvailableMailer.role_has_become_available(meeting_id,role_id).deliver
  end


end
