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
      worker.perform_async(*args)
    end
  end

  def relay_email(id)
    if email_available? == true
      DistributionListMailer.relay(id).deliver
    end
  end
  

end
