module SystemServices

  def email_available_for_club?(club)
    global_email_on = false
    config = SysConfiguration.where("config_key = ?", "system.email.global.send").first
    if config.nil?
      global_email_on = false
    else
      global_email_on = (config.config_value == 'Y')
    end
    result = club.email_enabled && global_email_on
    result 
  end


  def send_email(worker, *args, club )
    if email_available_for_club?(club) == true
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
        #RoleSignupNotificationMailer.member_signed_up_for_role(member_id,meeting_id,role_id).deliver
      end

      if worker == 'SwitchRequestMailerWorker' 
        handled = true
        member_id = args[0]
        assignment_id = args[1]
        SwitchRequestMailerWorker.perform_async(member_id,assignment_id)
      end
    end     
  end

  def relay_email id, message
    

    if email_available? == true
      DistributionListMailer.relay(id,message).deliver
    end
  end

  def send_email_to_sysadmin id
    if email_available? == true
      DistributionListMailer.send_to_sysadmin(id).deliver
    end
  end

end
