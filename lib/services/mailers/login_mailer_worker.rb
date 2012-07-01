require 'iron_worker'
#require 'net/smtp'


class LoginMailerWorker  < IronWorker::Base

  attr_accessor :x, :message   

  merge_gem 'actionmailer',{:require=>'action_mailer',:version=>'3.2.3'}


  merge_mailer 'app/mailers/login_mailer', {'app/views/login_mailer'=>"member_logged_in"}


  def initialize
    IronWorker.configure do |config|     
      config.token = ENV['IRON_WORKER_TOKEN']
      config.project_id = ENV['IRON_WORKER_PROJECT_ID']
    end

  end

  def configure_smtp(cfg)
    @smtp_address = cfg.smtp_address
    @smtp_domain = cfg.smtp_domain
    @user_account = cfg.user_account
    @password = cfg.password
    @from_address = cfg.from_address
    @to_address = cfg.to_address
  end

  def info(club_name, first_name, last_name)
    @club_name = club_name
    @first_name = first_name
    @last_name = last_name
  end  


  def run
    ActionMailer::Base.smtp_settings={
        :address => @smtp_address,
        :port => 587,
        :domain =>  @smtp_domain,
        :user_name => @user_account,
        :password => @password,
        :authentication => 'plain',
        :enable_starttls_auto => true}
    LoginMailer.member_logged_in(@club_name, @first_name,@last_name).deliver!
  end

  


end
