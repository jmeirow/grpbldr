# Generated meeting assignments of members to roles for a give set of meetings
#
class AssignmentPolicy  

  def initialize(meeting_ids, club_id)
    @club_id = club_id
    @start_time = DateTime.now
    @meetings = Meeting.find(meeting_ids)
    @members = Member.where("club_id = ?", @club_id)
    @nums = Array.new 
  end





  def make_assignments 
    
    @meetings.each do |meeting|
      roles = Role.needed_for_meeting(meeting)
      roles.each do  |role|
        next unless role.assignable
        20.times do
          member = next_suitable_member(meeting,role)
          if !member.nil?
            Assignment.create(:meeting_id => meeting.id, 
                              :role_id => role.id, 
                              :member_id => member.id)

            break
          end
        end
      end
    end
    @assignments = Assignment.where(assignment_sql, @meetings, @start_time)
  end



private

  def next_suitable_member(meeting,role)
    @members.shuffle!
    (@members.count).times do |x|
      member=@members[x]
      bypass_reasons = evaluate_suitability(member, meeting, role)
      return member if suitable?(bypass_reasons)
      create_assignment_report(member,meeting,role,bypass_reasons)
    end
    return nil
  end





  def create_assignment_report(member,meeting,role,bypass_reasons)
    AssignmentReport.create(:club_id => @club_id, 
        :member_id => member.id, 
        :meeting_date => meeting.meeting_date, 
        :role_id =>role.id,
        :reason => assignment_report_msg(bypass_reasons))
  end





  def suitable?(bypass_reasons)
    return false if bypass_reasons[:available] == false  
    return false if bypass_reasons[:experienced] == false
    return false if bypass_reasons[:already_assigned_role_for_this_meeting]  
    return false if bypass_reasons[:recently_had_role]  
    return false if bypass_reasons[:member_not_assignable] == true   
    return true
  end




  
  def evaluate_suitability(member,meeting,role)
    bypass_reasons = Hash.new
    bypass_reasons[:member_not_assignable] = !member.assignable
    bypass_reasons[:available] = available?(member,meeting)
    bypass_reasons[:experienced] = sufficiently_experienced?(member,role)  
    bypass_reasons[:already_assigned_role_for_this_meeting] = already_assigned_role_for_meeting?(meeting,member)  
    bypass_reasons[:recently_had_role] = recently_had_role?(member,meeting,role) 
    return bypass_reasons
  end




  def assignment_report_msg(bypass_reasons)
    return "experience" if !bypass_reasons[:experienced]
    return "availability" if !bypass_reasons[:available]
    return "already has mtg role" if bypass_reasons[:already_assigned_role_for_this_meeting]
    return "experience" if !bypass_reasons[:experienced]
    return "recently had role" if bypass_reasons[:recently_had_role]
    return "member is not assignable" if bypass_reasons[:member_not_assignable]
    return "no reason..."
  end


  def already_assigned_role_for_meeting?(meeting,member)
    Assignment.where(already_had_role_sql, member.id, meeting.id).count > 0
  end


  def available?(member,meeting)
    Absence.where(absence_sql,member.id, meeting.meeting_date).count == 0
  end


  def recently_had_role?(member,current_meeting, role )
    meetings = Meeting.where("club_id = ? and id < ?", @club_id, current_meeting.id).last(role.meetings_to_skip_before_assigning_again)
    assignments = Assignment.where("meeting_id in (?) and member_id = ? and role_id = ?", meetings, member.id,role.id).count
    return assignments > 0
  end


  def sufficiently_experienced?(member,role)
    days = (Date.today - member.start_date).to_i 
    months_experience = days/30
    return months_experience >= role.minimum_required_experience 
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
