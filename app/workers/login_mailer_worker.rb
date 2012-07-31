 
 
class LoginMailerWorker

  include Sidekiq::Worker

  def perform(worker, *args)
  	 
    LoginMailer.member_logged_in(*args).deliver
  end

end
