  class Assignment < ActiveRecord::Base

  # modules
  include ActiveBuilder

  #access
  attr_accessible :meeting_id, :member_id, :role_id, :id  
   


  #callbacks
  after_find :gb_set_attribute_methods_from_attributes


  #associations
  belongs_to :meeting, :counter_cache => true
  
  def meeting
    self[:meeting_id].nil? ?   nil :   Meeting.find(self[:meeting_id])
  end


  def role
    self[:role_id].nil? ? nil : Role.find(self[:role_id])
  end
  
  def member
    self[:member_id].nil? ? nil : Member.find(self[:member_id])
  end
  
   


  def self.member_for_meeting_and_role(meeting_id, role_id)
    name = 'Open'
    xxx = Assignment.where("meeting_id = ? and role_id = ?",meeting_id, role_id)
    xxx.each do |x| 
      name = Member.find(x.member_id).full_name  
    end
    name
  end
  
  def self.available_assignments(club_id)
      available_assignments = Array.new
      Meeting.all_future(club_id).each do |meeting|
        Role.needed_for_meeting(meeting).each do |role|
          available_assignments << AvailableAssignment.new(meeting,role)
        end
      end
      available_assignments
  end
  
  def self.all_assignments(club_id)
      available_assignments = Array.new
      Meeting.all_future(club_id).each do |meeting|
        Role.roles(club_id).each do |role|
          available_assignments << AvailableAssignment.new(meeting,role)
        end
      end
      available_assignments
  end  
  
  def self.available_assignments_for_role(role_id,club_id)



      role_ids = Array.new
      if role_id > 0 
        role_ids << role_id
      else
        RoleGroupAssociation.where("role_group_id = ?", (role_id * -1)).each do |assoc|
          role_ids << assoc.role_id
        end
      end

      available_assignments = Array.new
      Meeting.all_future(club_id).each do |meeting|
        Role.needed_for_meeting(meeting).each do |role|
          if  role_ids.include?(role.id)  
            available_assignments << AvailableAssignment.new(meeting,role)  
          end
        end
      end
      available_assignments
  end  
  
  def self.all_assignments_for_role(role_id,club_id)
     
      role_ids = Array.new
      if role_id > 0 
        role_ids << role_id
      else
        RoleGroupAssociation.where("role_group_id = ?", (role_id * -1)).each do |assoc|
          role_ids <<  assoc.role_id
        end
      end



      available_assignments = Array.new
      Meeting.all_future(club_id).each do |meeting|
         Role.roles(club_id).each do |role|
          
          if  role_ids.include?(role.id)  
            available_assignments << AvailableAssignment.new(meeting,role)  
          end
        end
      end
      
      available_assignments
  end  

end































