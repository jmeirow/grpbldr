class Club < ActiveRecord::Base
  	include ActiveModel::MassAssignmentSecurity
	
	attr_accessible :name, :id 
	

    validates_presence_of :name
  
  
  def self.roles
    Role.where("club_id = ?", id)
  end

  def next_meeting
  	Meeting.where("club_id = ? and meeting_date >= ?", self.id, Date.today ).order("meeting_date").first
  end

  

end
