class Policy  





  def initialize(meeting_ids, club_id)
     
    @start_time = DateTime.now
    @meetings = Meeting.find(meeting_ids)
    @members = Member.where("club_id = ?", club_id )  
    @count = @members.count

  end
  



  def make_assignments 
    @meetings.each do |meeting|
      roles = Role.needed_for_meeting(meeting)
      roles.each do  |role|
        
        member = next_suitable_member(meeting,role)
        next if member.nil?
        Assignment.create(:meeting_id => meeting.id, 
            :role_id => role.id, :member_id => member.id)
      end
    end
    @assignments = Assignment.where(assignment_sql, meetings, @start_time)
  end





  def next_suitable_member(meeting,role)
    idx = getrandom(@count)
    offset = compute_offset(@count,idx)
    @count.times do |x|
      member=@members[offset[x]]
      bypass_reasons = evaluate_suitability(member, meeting, role)
      return member if any_are_true?(bypass_reasons)
      create_assignment_report(member,meeting,role,bypass_reasons)
    end
    return nil
  end





  def any_are_true?(bypass_reasons)
    true_hash = bypass_reasons.select {|k,v| v == true }
    return true_hash.count > 0
  end





  def evaluate_suitability(member,meeting,role)
    bypass_reasons = Hash.new
    bypass_reasons[:available] = available?(member,meeting)
    bypass_reasons[:experienced] = sufficiently_experienced?(member,role)  
    bypass_reasons[:already_assigned_role_for_this_meeting] = already_assigned_role_for_meeting(meeting,member)    
  end





  def create_assignment_report(member,meeting,role,bypass_reasons,club_id)
    AssignmentReport.create(:club_id => club_id, 
        :member_id => member.id, 
        :meeting_date => meeting.meeting_date, 
        :role_id =>role.id,
        :reason => assignment_report_msg(bpyass_reasons))
  end




  def getrandom(count)
    @nums = Array.new if @nums.nil?
    while true
      x = rand(count)
      if @nums.last(count-1).index(x).nil?
        @nums << x
        break
      end
    end
    return x
  end 





  def compute_offset(count,idx)
    offset = Array.new(count)
    count.times do |x|
      offset[x] = x
    end
    offset.rotate!(count-idx)
    idx.times do |y|
      offset[y]=y-idx
    end
    return offset
  end





  def assignment_report_msg(available, experienced,already_assigned_role_for_this_meeting)
    return "already has mtg role/experience" if !experienced && already_assigned_role_for_this_meeting
    return "availability/experience" if !available && !experienced
    return "availability" if !available
    return "availability" if already_assigned_role_for_this_meeting
    return "experience" if !experienced
  end





  def already_assigned_role_for_meeting(meeting,member)
    Assignment.where(already_had_role_sql, member.id, meeting.id).length > 0
  end





  def available?(member,meeting)
    return Absence.where(absence_sql,member.id, meeting.meeting_date).count == 0
  end





  def sufficiently_experienced?(member,role)
    diff = DateTime.now - member.start_date
    return (diff.to_i/30 > role.minimum_required_experience)
  end





  def already_had_role_sql
    "member_id = ? and meeting_id = ?"
  end





  def absence_sql
    "member_id = ? and ? between start_date and end_date"
  end





  def assignment_sql
    "meeting_id in (?) and created_at > ?"
  end





end
