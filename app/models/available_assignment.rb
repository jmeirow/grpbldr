 

class AvailableAssignment < ActiveRecord::Base
  
  # modules
 #include ActiveBuilder

  #access
  attr_accessible :meeting, :role, :assignment
  attr_accessor :prior_committments, :meeting, :role, :assignment, :meeting_date
  
   
  #callbacks
  #after_find :gb_set_attribute_methods_from_attributes
  
  def initialize (meeting, role)
    @meeting = meeting
    @meeting_date = @meeting.meeting_date
    @role = role
    @assignment = Assignment.where("role_id = ? and meeting_id = ?", role.id, meeting.id).first
  end
  
end
