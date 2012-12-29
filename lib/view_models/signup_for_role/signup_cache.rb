
class SignupCache

  attr_reader :current_members, :meetings, :roles, :role_groups, :role_group_associations, :meeting_types, :assignments, :role_meeting_types
  
  def initialize club,meeting_type_id
    @current_members = Member.current(club).sort_by(&:last_name)
    @meetings = Meeting.where("club_id = ? and meeting_date >= ?  ", club.id, Date.today)
    @assignments = Assignment.where(" meeting_id in (?)", @meetings.map {|x| x.id}  )
    @meeting_types = MeetingType.where("club_id = ?", club.id).order("description")
   
   

    @role_meeting_types = RoleMeetingType.where("meeting_type_id in (?)", @meeting_types.map{|x| x.id})
    @roles = Role.where("club_id = ? and id in (?)",club.id, RoleMeetingType.where("meeting_type_id = ? ",meeting_type_id).map {|x| x.role_id})    
    @role_group_associations = RoleGroupAssociation.where("club_id = ? and role_id in (?)", club.id, @roles.map {|x| x.id } )
    @role_groups = RoleGroup.where("club_id = ? and id in (?)", club.id, @role_group_associations.map {|x| x.role_group_id } )

  end

end

