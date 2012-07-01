#require 'custom/batch_worker.rb'
#require 'custom/email_worker.rb' 
#require 'custom/smtp_config.rb'




class BatchController <  ApplicationController


  


  def bootstrap

    if current_user_is_super_user?  
     
      worker = BatchWorker.new
      worker.configure(ENV['GB_BATCH_RUN_URL'])
       
      if Rails.env.production?
        worker.schedule(
         :start_at=>1.minutes.from_now,
         :run_every=>15)
      else
        worker.run
      end
      end


  end


  def run
    if current_user_is_super_user?  
      worker = EmailWorker.new
      worker.configure_smtp(SmtpConfig.new)
      worker.message = "Subject: Invoked from URL\n\nMessage sent at #{Time.now.strftime('%H:%l:%S')}"
      worker.queue
      end

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
