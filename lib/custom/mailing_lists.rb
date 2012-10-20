class MailingLists



  def active_members(club_id, caller)

   
   
    mailer_type = caller.class.name 
    notification_type = NotificationType.where("mailer_type = ?", mailer_type).first


    config = SysConfiguration.where("config_key = ?", "system.email.global.dist_list.override.enabled").first
    if config && config.config_value == 'Y'
      config = SysConfiguration.where("config_key = ?", "system.email.global.dist_list.override").first
      if config 
        return config.config_value  
      else
        raise 'system.email.global.dist_list.override.enabled was "Y" and system.email.global.dist_list.override was not present.'
      end
    end
    email_addresses = Array.new
    members = Member.where("club_id = ? and ? between start_date and end_date", club_id, Time.now)


    members.each do |member|
      if MemberNotificationPreference.where("member_id = ? and notification_type_id = ? and enabled = true ", member.id, notification_type.id).length > 0
        puts "adding #{member.full_name} to dist list"
        email_addresses << member.email  
      else
        puts "skipping #{member.full_name} because they have not opted in to this notification"
      end
    end
    return email_addresses.join(",")
      
  end


  def positions(club_id)
  end


  def next_meeting(club_id)
  end






end
