
require 'iron_worker'


class TestEmailWorker  < IronWorker::Base

  attr_accessor :x, :message   

  merge_gem 'actionmailer',{:require=>'action_mailer',:version=>'3.2.3'}


  merge_mailer 'app/mailers/test_mailer', {'app/views/test_mailer'=>"test"}


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

  def info(dist_list)
    @dist_list = dist_list
  end  


  def run
      ActionMailer::Base.smtp_settings = {
      :user_name => "joe.meirow@gmail.com",
      :password => "monie423",
      :domain => "groupbuilderplus.com",
      :address => "smtp.sendgrid.net",
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true
      }
    TestMailer.test(@dist_list).deliver!
  end

  


end
