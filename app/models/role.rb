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
  
	def self.needed_for_meeting(meeting,cache)
    filled_assignments = Assignment.where("meeting_id = ?", meeting.id )
    needed = Array.new
    cache.roles.select do |role| 
      needed << role unless filled_assignments.map{ |y| y.role_id }.include? role.id  
    end
    needed
  end
  
  def self.roles(club_id,meeting_type_id,cache)
    role_ids = RoleMeetingType.where("meeting_type_id = ?",  meeting_type_id).map { |role_for_meeting_type | role_for_meeting_type.role_id }
    Role.where("club_id = ?  and id in (?) ", club_id, role_ids).order("description")
  end

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
