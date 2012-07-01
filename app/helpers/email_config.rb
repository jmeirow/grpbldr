module EmailConfig



  def email_available?

    config = SysConfiguration.where("config_key = ?", "system.email.global.send").first
    result = config && config.config_value == "Y" 
     
    result
  end
  

end
