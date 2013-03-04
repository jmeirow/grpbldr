require 'pry'
require 'pry_debug' 

class Enrollment    
  include ActiveModel::MassAssignmentSecurity
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :last_name,  :first_name,  :club_name, :start_date, :club_id, :end_date, :email, :password, :password_confirmation
  
  validates :first_name, :last_name, :club_name, :email, :presence => true
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  attr_accessible :last_name,  :first_name,  :club_name, :start_date, :club_id, :end_date, :email, :password, :password_confirmation

  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  
 

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
    ActiveRecord::Base.transaction do
      begin

        
        cnt = User.where("email = ?", email ).count

        if cnt == 0
          User.create(:email => email, :password => password, :password_confirmation => password_confirmation)
        end

        club = Club.create(:name => club_name)
 
         
        Member.create(:first_name => first_name, :last_name => last_name, :email => email, :club_id => club.id, :start_date => Date.today, :end_date => Date.parse("9999/12/31") )
     
        Admin.create(:club_id => club.id, :email => email)

        meeting_type = MeetingType.create(:description => 'Regular', :club_id => club.id, :is_default => true, :hour => 12, :minute => 0, :am_pm => 'PM', :meeting_time => "12:00 PM")
        agenda_def = AgendaDefinition.create(:description => "Regular meeting agenda template.", :meeting_type_id => meeting_type.id, :name => "Regular", :club_id => club.id, :show_absent_members =>false, :show_next_meeting_open_roles => false, :show_this_meeting_open_roles => false )
        club.default_meeting_type_id = meeting_type.id 
        club.default_agenda_definition_id = agenda_def.id 
        club.save
        
      rescue ActiveRecord::StatementInvalid => e1
        GenericLog.create(:information =>  "failed in 'create_other_models' e1 => #{e1} ")
        raise ActiveRecord::Rollback

      end
    
    end
  end    
end




