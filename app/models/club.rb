require 'custom/string_helper.rb'

class Club < ActiveRecord::Base
  	
  include ActiveModel::MassAssignmentSecurity
	
  attr_accessible :name, :email_enabled, :email_name

  validates_presence_of :name
  validate :email_name_already_in_use
  validate :email_name_contains_blanks
  validate :email_name_numeric_but_not_club_number
  
  def self.roles
    Role.where("club_id = ?", id)
  end

  def next_meeting
  	Meeting.where("club_id = ? and meeting_date >= ?", self.id, Date.today ).order("meeting_date").first
  end

  def email_name_already_in_use
    if (Club.where("email_name = ? and id <> ?", self[:email_name], self[:id]).count > 0)
       errors.add(:email_name, "is already in use.")
    end
  end

  def email_name_numeric_but_not_club_number
    if StringHelper.is_integer? self[:email_name] 
      if self[:email_name] != self[:id].to_s  
        errors.add(:email_name, "can't be numeric unless it is your club number (#{self[:id]}).")
      end
    end
  end
 
  def email_name_contains_blanks
    if (self[:email_name].include?(" ") || self[:email_name].include?("\t") )
      errors.add(:email_name, "can't contain blanks.")
    end
  end

end
