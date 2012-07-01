ActionMailer::Base.smtp_settings = {  
  :address              =>  ENV['SMTP_ADDRESS'],  
  :port                 =>  ENV['SMTP_PORT'],  
  :domain               =>  ENV['SMTP_DOMAIN'],  
  :user_name            =>  ENV['SMTP_USER_NAME'],  
  :password             =>  ENV['SMTP_PASSWORD'],
  :authentication       =>  ENV['SMTP_AUTHENTICATION'], 
  :openssl_verify_mode  => 'none', 
  :enable_starttls_auto => true  
} 
 