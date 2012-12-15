require 'custom/params_to_array.rb'
require 'custom/state_changes.rb'



class Role < ActiveRecord::Base


  # modules
  include ActiveBuilder

  #access
  attr_accessible :description, :assignable,   :minimum_required_experience, :meetings_to_skip_before_assigning_again, :id


  has_many :role_group_associations
  has_many :role_groups, :through => :role_group_associations

  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes

  #validation
  validates :description, :presence => true
	
	
  def count_of_role_group_associations
    RoleGroupAssociation.where('role_id = ?', self[:id]).length
  end

  def count_of_assignments
    Assignment.where('role_id = ?', self[:id]).length
  end
	

  
	def self.needed_for_meeting(meeting)

    assignments = Assignment.where("meeting_id = ? ", meeting.id)

      
    role_ids =  RoleMeetingType.where("meeting_type_id = ?",  meeting.meeting_type_id).map { |role_for_meeting_type | role_for_meeting_type.role_id }

    if assignments.nil?  || assignments.length == 0
      return Role.where("club_id = ? and id in (?)", meeting.club_id, role_ids)
    else
      s = ""
      assignments.each do |a|
        s = s + a.role_id.to_s
        s = s + ','
      end
      s = s[0..-2]
      roles = Role.where("club_id = ? and id in (?) and id not in (#{s})", meeting.club_id, role_ids  ).order("description")
      return roles
    end
  end
  
  
  # def self.get_role_ids_from(assignments)
  #   assignments.each do |a|
  #     s = s + a.role_id.to_s + ","
  #   end
  #   return s.chomp
  # end




  
  def self.roles(club_id,meeting_type_id)
    role_ids = RoleMeetingType.where("meeting_type_id = ?",  meeting_type_id).map { |role_for_meeting_type | role_for_meeting_type.role_id }
    Role.where("club_id = ?  and id in (?) ", club_id, role_ids).order("description")
  end









  # def self.roles_with_groups_for_meeting_type(club_id,meeting_type_id)


  #   # This method insures that only roles and role group 
  #   # associated with the given meeting type
  #   # are returned to the caller.

 
  #   unsorted = Hash.new
    
  #   role_ids = RoleMeetingType.where("meeting_type_id = ?",  meeting_type_id).map { |role_for_meeting_type | role_for_meeting_type.role_id }
    

  #   Role.where("club_id = ? and id in (?)", club_id, role_ids).order("description").each do |role|
  #     unsorted[role.id] = role.description
  #   end

  #   role_groups =  RoleGroupAssociation.where("role_id in (?)",  role_ids).each { | role_group_assoc_rec | role_group_assoc_rec.role_group_id }

  #   RoleGroup.where("club_id = ? and id in (?)", club_id, role_groups).order("description").each do |group|
  #     unsorted[group.id * -1] = group.description
  #   end

  #   RoleGroupAssociation.where("club_id = ? and role_id in (?)", club_id, role_ids).each do |assoc| 
  #     unsorted.delete(assoc.role_id)
  #   end
     
  #   unsorted.sort {|a,b| a[1] <=> b[1]}
    
  # end


  def self.role_meeting_type_prefix
    'mt_'
  end

  def self.refresh_role_meeting_types(role_id,params)
    selections_before = RoleMeetingType.where(" role_id = ?", role_id)
    selections_after = ParamsToArray.do(Role.role_meeting_type_prefix, params)
    state_changes = StateChanges.new(selections_before,selections_after)
    RoleMeetingType.delete(state_changes.deleted) if state_changes.deleted.length > 0
    state_changes.added.each {|meeting_type_id|  RoleMeetingType.create( :role_id => role_id, :meeting_type_id => meeting_type_id)}
  end








      
  
end
