require 'custom/string_helper.rb'

class Club < ActiveRecord::Base
  	
  #include ActiveModel::MassAssignmentSecurity
	
  include ActiveBuilder
  
    attr_accessible :name, :email_enabled,:domain
  
 

  validates_presence_of :name
  validate :domain_already_in_use 
  validate :domain_contains_blanks    
  validate :domain_numeric_but_not_club_number 
   

  validates :email_enabled, :inclusion => {:in => [true, false]}


  after_find :gb_set_attribute_methods_from_attributes
  after_create :default_domain_to_club_number


  def self.roles
    Role.where("club_id = ?", id)
  end

  def default_domain_to_club_number
    domain = id.to_s
  end
  

  def next_meeting
  	Meeting.where("club_id = ? and meeting_date >= ?", self.id, Date.today ).order("meeting_date").first
  end


  def domain_numeric_but_not_club_number
    errors.add(:domain, "can't be numeric unless equal to club ID.") if (StringHelper.is_i?(domain) && (domain.to_s != id.to_s))
  end

  def default_agenda_definition_id
    begin
      default_meeting_type = MeetingType.where("club_id = ? and is_default = true",id).first
      AgendaDefinition.where("meeting_type_id = ? ", default_meeting_type.id).first
    rescue Exception => e 
      
    end
  end

  def domain_contains_blanks
    errors.add(:domain, "can't contain blanks.") if  /\s/.match(domain.to_s)
  end

  def domain_already_in_use
    x = Club.where("domain = ? and id <> ?", domain.to_s, id)
    puts x
    if x.length > 0
       errors.add(:domain, "is already in use.")
    end
  end
end
