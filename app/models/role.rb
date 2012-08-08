class Role < ActiveRecord::Base


  # modules
  include ActiveBuilder

  #access
  attr_accessible :description, :assignable,   :minimum_required_experience, :meetings_to_skip_before_assigning_again


  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes

  #validation
  validates :description, :presence => true
	
	
	
	def self.needed_for_meeting(meeting)

    assignments = Assignment.where("meeting_id = ? ", meeting.id)

    if assignments.nil?  || assignments.length == 0
      return Role.where("club_id = ?", meeting.club_id)
    else
      s = ""
      assignments.each do |a|
        s = s + a.role_id.to_s
        s = s + ','
      end
      s = s[0..-2]
      roles = Role.where("club_id = ? and id not in (#{s})", meeting.club_id  ).order("description")
      return roles
    end
  end
  
  
  def self.get_role_ids_from(assignments)
    assignments.each do |a|
      s = s + a.role_id.to_s + ","
    end
    return s.chomp
  end


  
  def self.roles(club_id)
    Role.where("club_id = ?", club_id).order("description")
  end

def self.roles_with_groups(club_id)
    
    unsorted = Hash.new
    
    Role.where("club_id = ?", club_id).order("description").each do |role|
      unsorted[role.id] = role.description
    end

    RoleGroup.where("club_id = ?", club_id).order("description").each do |group|
      unsorted[group.id * -1] = group.description
    end

    RoleGroupAssociation.where("club_id = ?", club_id).each do |assoc| 
      unsorted.delete(assoc.role_id)
    end
     
    unsorted.sort {|a,b| a[1] <=> b[1]}





  end


      
  
end
