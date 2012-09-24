require 'custom/string_helper.rb'

class Club < ActiveRecord::Base
  	
  #include ActiveModel::MassAssignmentSecurity
	
  include ActiveBuilder
  
  attr_accessible :name, :email_enabled,:domain 
  validates_presence_of :name
  validate :domain_already_in_use 
  validate :domain_contains_blanks,  :on => :update
  validate :domain_numeric_but_not_club_number,  :on => :update
  validates :email_enabled, :inclusion => {:in => [true, false]}

  #callbacks
  after_find :gb_set_attribute_methods_from_attributes
  after_create :default_domain_to_club_number
 
 

  def self.roles
    Role.where("club_id = ?", id)
  end

  def default_domain_to_club_number
    self[:domain] = self[:id].to_s
  end
  

  def next_meeting
  	Meeting.where("club_id = ? and meeting_date >= ?", self.id, Date.today ).order("meeting_date").first
  end


  def domain_numeric_but_not_club_number
    if  self[:domain].nil? == false && 
        StringHelper.is_i?(self[:domain]) && 
        self[:domain] != self[:id].to_s
      errors.add(:domain, "can't be numeric unless it is your club number.")
    end
  end
 
  def domain_contains_blanks
    if self[:domain].index(' ').nil? == false 
      errors.add(:domain, "can't contain blanks.")
    end
  end
  def domain_already_in_use
    if Club.where("domain = ? and id <> ?", self[:domain], self[:id]).length > 0
       errors.add(:domain, "is already in use.")
    end
  end
end
