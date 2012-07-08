
 
class SwitchRequestMailerWorker
  
  include Sidekiq::Worker

  def perform(member_id,assignment_id)
    SwitchRequestMailer.request_switch(member_id,assignment_id).deliver
  end

end
