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
      if worker == "LoginMailerWorker"
        member_id = args[0]
        LoginMailerWorker.perform_async(member_id)
      end

      if worker == 'RoleHasBecomeAvailableMailerWorker' 
        meeting_id = args[0]
        role_id = args[1]
        RoleHasBecomeAvailableMailerWorker.perform_async(meeting_id,role_id)
      end


      if worker == 'RoleSignupNotificationMailerWorker' 
        member_id = args[0]
        meeting_id = args[1]
        role_id = args[2]
        RoleSignupNotificationMailerWorker.perform_async(member_id,meeting_id,role_id)
      end

      if worker == 'SwitchRequestMailerWorker' 
                handled = true
        member_id = args[0]
        assignment_id = args[1]
        SwitchRequestMailerWorker.perform_async(member_id,assignment_id)
      end
    end     
  end

  def relay_email(id, message)
    if email_available? == true
      DistributionListMailer.relay(id,message).deliver
    end
  end
  

end
