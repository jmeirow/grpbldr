 

class AvailableAssignment < ActiveRecord::Base
  
  # modules
  include ActiveBuilder

  #access
  attr_accessible :meeting, :role, :assignment
  attr_accessor :prior_committments
  
   
  #callbacks
  after_find :gb_set_attribute_methods_from_attributes
  
  def initialize (meeting, role)
    @meeting = meeting
    @role = role
    Assignment.where("role_id = ? and meeting_id = ?", role.id, meeting.id).each do |assignment|
      @assignment = assignment
    end
  end
  
  def meeting
    @meeting
  end
  
  def role
    @role
  end
  
  def assignment
    @assignment
  end


  
 
  
  
end
