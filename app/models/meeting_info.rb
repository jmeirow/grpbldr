require './lib/view_models/meetings/meeting_index_cache.rb'


class MeetingInfo



  def initialize meeting
    @club = Club.find(meeting.club_id)
    @meeting = meeting
    @cache = MeetingIndexCache.new(@club, meeting.meeting_type_id)
  end



  def unfilled_roles_count
    Role.roles(@meeting.club_id, @meeting.meeting_type_id,@cache).length -  @meeting.assignments_count
  end
  
  def unfilled_roles 
    @unfilled_roles = Assignment.available_assignments(@meeting.club_id,@meeting.meeting_type_id,@cache)
  end
  
  def has_available_roles?
    unfilled_roles > 0
  end



end
