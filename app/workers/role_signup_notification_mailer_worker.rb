

class RoleSignupNotificationMailerWorker   

  include Sidekiq::Worker

  def perform(member_id,meeting_id,role_id)
    Rails.logger.info("INSIDE OF RoleSignupNotificationMailerWorker.perform.................................................")
    RoleSignupNotificationMailer.member_signed_up_for_role(member_id,meeting_id,role_id).deliver
  end


end
