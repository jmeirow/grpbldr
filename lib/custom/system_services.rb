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
        worker.perform_async(worker,member_id)
      end

      if worker.is_a? RoleSignupNotificationMailerWorker 
        member_id = args[0]
        meeting_id = args[1]
        role_id = args[2]
        worker.perform_async(worker,member_id,meeting_id,role_id)
      end


      if worker.is_a? RoleHasBecomeAvailableMailerWorker 
        member_id = args[0]
        role_id = args[1]
        worker.perform_async(worker,member_id,role_id)
      end


      if worker.is_a? SwitchRequestMailerWorker 
        member_id = args[0]
        assignment_id = args[1]
        worker.perform_async(worker,member_id,assignment_id)
      end


 


    end     
  end

  def relay_email(id, message)
    if email_available? == true
      DistributionListMailer.relay(id,message).deliver
    end
  end
  

end
