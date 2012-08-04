module SystemServices

  def email_available?
    val = 'N'
    config = SysConfiguration.where("config_key = ?", "system.email.global.send").first
    if config.nil?
      val = 'N'
    else
      val = config.config_value
    end
    return val == 'Y'
  end


  def send_email(worker, *args )
    if email_available? == true
      if worker.is_a? LoginMailerWorker 
        member_id = args[0]
        logger.banner "member_id after pulling from args is #{member_id}"
        worker.perform_async(worker,member_id)
      else
        id = args[0]
        worker.perform_async(worker,args)
      end
    end     
  end

  def relay_email(id, message)
    if email_available? == true
      DistributionListMailer.relay(id,message).deliver
    end
  end
  

end
