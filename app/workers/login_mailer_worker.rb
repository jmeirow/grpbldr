 
 
class LoginMailerWorker

  include Sidekiq::Worker

  def perform(worker,member_id)
    LoginMailer.member_logged_in(member_id).deliver
  end

end
