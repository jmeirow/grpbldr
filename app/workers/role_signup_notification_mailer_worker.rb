

class RoleSignupNotificationMailerWorker

  include Sidekiq::Worker

  def perform(*args)
    member_id = args[0]
    meeting_id = args[1]
    role_id = args[2]
    RoleSignupNotificationMailer.member_signed_up_for_role(member_id,meeting_id,role_id).deliver
  end


end
