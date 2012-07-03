 



class BatchController <  ApplicationController


  


  def bootstrap

    

  end


  def run
    

  end

  def toggle
    
    if current_user_is_super_user?  

      speakeasy = Club.where("name = ?","SpeakEasy Toastmasters of Shelby Twp").first
      joe = Member.where("last_name = ? and club_id != ?",'Meirow',speakeasy.id)
      joe.each do |record|
        if (record.email == "joe.meirow@gmail.com")
          record.email = "joe.meirow@yahoo.com"
        else
          record.email = "joe.meirow@gmail.com"
        end
        record.save
        @email = record.email

      end
    end

  end

  def take_down

  end

  def bring_up
      
    if current_user_is_super_user?  

      cfg =  SysConfiguration.where("config_key = ?", "web.status").first
      cfg.config_value = "up"
      cfg.save
    end
      
  end





end
