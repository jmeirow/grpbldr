class MeetingIndexCache

  attr_accessor  :roles,   :assignments, :role_meeting_types, :meetings
  
  def initialize club,meeting_type_id
    @assignments = Assignment.where(" meeting_id = ?", meeting_type_id  )
    @meetings = Array.new
    @role_meeting_types = RoleMeetingType.where("meeting_type_id = ? ", meeting_type_id)
    @roles = Role.where("club_id = ? and id in (?)",club.id, @role_meeting_types.map {|x| x.role_id}) 
    #@roles   
  end
end

