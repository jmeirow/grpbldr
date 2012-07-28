class SmtpConfig 

  #attr_accessor :smtp_domain, :user_account, :password, :from_address, :to_address

  def initialize
    
    @smtp_domain  = ENV['GB_SMTP_DOMAIN']
    @smtp_address = ENV['GB_SMTP_ADDRESS']
    @user_account = ENV['GB_SMTP_USER_NAME']
    @password     = ENV['GB_SMTP_PASSWORD']
    @from_address = ENV['GB_SMTP_NOTIFICATION_EMAIL']
    @to_address   = ENV['GB_SMTP_NOTIFICATION_EMAIL']

  end

  def smtp_domain
    @smtp_domain
  end
  def smtp_domain=(value)
    @smtp_domain = value
  end
  def smtp_address
    @smtp_address
  end
  def smtp_address=(value)
    @smtp_address = value
  end



  def user_account
    @user_account
  end
  def user_account=(value)
    @user_account = value
  end


  def password
    @password
  end
  def password=(value)
    @password = value
  end

  def from_address
    @from_address
  end
  def from_address=(value)
    @from_address = value
  end

  def to_address
    @to_address
  end
  def to_address=(value)
    @to_address = value
  end

end
