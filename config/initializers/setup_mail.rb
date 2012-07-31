ActionMailer::Base.smtp_settings = {  
  :address              =>  ENV['GB_SMTP_ADDRESS'],  
  :port                 =>  ENV['GB_SMTP_PORT'],  
  :domain               =>  ENV['GB_SMTP_DOMAIN'],  
  :user_name            =>  ENV['GB_SMTP_USER_NAME'],  
  :password             =>  ENV['GB_SMTP_PASSWORD'],
  :authentication       =>  ENV['GB_SMTP_AUTHENTICATION'], 
  :openssl_verify_mode  => 'none', 
  :enable_starttls_auto => true  
} 
 