

class DistributionListMailerWorker												
	
  include Sidekiq::Worker

  def perform(id)
    DistributionListMailer.relay(id).deliver
  end

end
