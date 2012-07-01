class MailingLists



  def active_members(club_id)

   

    config = SysConfiguration.where("config_key = ?", "system.email.global.dist_list").first
      if config
        return config.config_value
      else
        email_addresses = Array.new
        members = Member.where("club_id = ? and ? between start_date and end_date", club_id, Time.now)
        members.each do |member|
          email_addresses << member.email 
        end
        email_addresses.join(",")
      end
      
  end


  def positions(club_id)
  end


  def next_meeting(club_id)
  end






end
