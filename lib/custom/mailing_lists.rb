class MailingLists



  def active_members(club_id)

   


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
      email_addresses << member.email 
    end
    return email_addresses.join(",")
      
  end


  def positions(club_id)
  end


  def next_meeting(club_id)
  end






end
