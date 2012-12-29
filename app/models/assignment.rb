 

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
  
  def self.member_for_meeting_and_role(meeting_id, role_id,cache)

    # TODO - Cache this (and other IO intensive/repetitive searches)
    # as instance variables in the controller and use them in the views
    # Specifically, get ALL for all future meetings in one query.
    # This code is hitting two tables for each role for each future 
    # meeting.

    name = 'Open'
    #xxx = Assignment.where("meeting_id = ? and role_id = ?",meeting_id, role_id)
    xxx = cache.assignments.select{|x| x.meeting_id == meeting_id && x.role_id == role_id}
    xxx.each do |x| 
      name = Member.find(x.member_id).full_name  
    end
    name
  end
  
  def self.available_assignments(club_id,meeting_type_id,cache)
    available_assignments = Array.new
    cache.meetings.select{|x| x.meeting_type_id == meeting_type_id}.each do |meeting|
      Role.needed_for_meeting(meeting,cache).each do |role|
        available_assignments << AvailableAssignment.new(meeting,role)
      end
    end
    available_assignments.sort_by(&:meeting_date)
  end
  
  def self.all_assignments(club_id,meeting_type_id,cache)
    available_assignments = Array.new
     cache.meetings.select{|x| x.meeting_type_id == meeting_type_id}.each do |meeting|
      cache.roles.each do |role|
        available_assignments << AvailableAssignment.new(meeting,role)
      end
    end
    available_assignments.sort_by(&:meeting_date)
  end  



  # ====================================================================


  # def select_meeting? options, meeting
  #   return true if options[:meeting_type_id].nil? || options[:meeting_type_id] == meeting.meeting_type_id
  #   false
  # end

  # def requested_roles options
  #   if options[:role_id]
  #     Assignment.get_role_ids( options[:role_id],  options[:club_id] , options[:meeting_type_id]   )
  #   else
  #     cache.roles
  #   end
  # end

  # def self.assignments cache, options
  #   available_assignments = Array.new
  #   cache.meetings.select{|x| select_meeting?(options, x) }.each do |meeting|
  #    requested_roles(options).each do |role|
  #       available_assignments << AvailableAssignment.new(meeting,role)
  #     end
  #   end
  #   available_assignments   
  # end


 # ====================================================================


  
  def self.get_role_ids (role_id,club_id,meeting_type_id)
    roles_for_meeting_type = RoleMeetingType.role_ids_for_meeting_type(meeting_type_id)
    role_ids = Array.new
    if role_id > 0 
      role_ids << role_id 
    else
      RoleGroupAssociation.where("role_group_id = ?", (role_id.abs)).each do |assoc|
        role_ids <<  assoc.role_id if roles_for_meeting_type.include? assoc.role_id
      end
    end
    role_ids 
  end



  def self.available_assignments_for_role(role_id,club_id,meeting_type_id,cache)
    role_ids = get_role_ids(role_id,club_id,meeting_type_id)
    available_assignments = Array.new
    cache.meetings.select{|x| x.meeting_type_id == meeting_type_id}.each do |meeting|
      Role.needed_for_meeting(meeting,cache).each do |role|
        if  role_ids.include?(role.id)  
          available_assignments << AvailableAssignment.new(meeting,role)  
        end
      end
    end
    available_assignments.sort_by(&:meeting_date)
  end  
  
  def self.all_assignments_for_role(role_id,club_id,meeting_type_id,cache)
    role_ids = get_role_ids(role_id,club_id,meeting_type_id)
    available_assignments = Array.new
    cache.meetings.select{|x| x.meeting_type_id == meeting_type_id}.each do |meeting|
      cache.roles.each do |role|
        if  role_ids.include?(role.id) &&  
          available_assignments << AvailableAssignment.new(meeting,role)  
        end
      end
    end
    available_assignments.sort_by(&:meeting_date)
  end  




end































