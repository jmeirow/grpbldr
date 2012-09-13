 

class Enrollment    
  include ActiveModel::MassAssignmentSecurity
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  
  validates :first_name, :last_name, :club_name, :email, :password, :password_confirmation,   :presence => true
  
  attr_accessor :last_name,  :first_name,  :club_name, :start_date, :club_id, :end_date, :email, :password, :password_confirmation
  
  attr_accessible :last_name,  :first_name,  :club_name, :start_date, :club_id, :end_date, :email, :password, :password_confirmation



  def persisted?
    false
  end

  
  def initialize(attributes={})
    attributes.each do |name, value|
      
      send("#{name}=",value)
    end
  end  
  
  # def initialize(*args)
  #   super(*args)
  # end
  
  def create_other_models
    User.transaction do
      begin

        
        cnt = User.where("email = ?", email ).count

        if cnt == 0
          User.create(:email => email, :password => password, :password_confirmation => password_confirmation)
        end

        club = Club.create(:name => club_name)
 
        Member.create(:first_name => first_name, :last_name => last_name, :email => email, :club_id => club.id, :start_date => Date.today, :end_date => Date.parse("9999/12/31") )
     
        Admin.create(:club_id => club.id, :email => email)


        MeetingType.create(:description => 'Regular', :club_id => club.id, :is_default => true, :hour => 12, :minute => 0, :am_pm => 'PM')

 

      rescue ActiveRecord::StatementInvalid
        raise ActiveRecord::Rollback
      end
    
    end
  end    
end




