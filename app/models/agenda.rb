require 'custom/running_time.rb'

class Agenda

  def initialize(meeting_id, agenda_definition_id)
    @meeting = Meeting.find(meeting_id)
    @roles = Hash.new
    @agenda_top = AgendaTop.where(" agenda_definition_id = ?", agenda_definition_id).first
    @agenda_bottom = AgendaBottom.where(" agenda_definition_id = ?", agenda_definition_id).first
    @agenda_line_items = AgendaLineItem.where(" agenda_definition_id = ? and include_in_agenda = ?", agenda_definition_id, 'Yes').order("sequence_nbr asc")

    set_times_for_this_meeting(meeting_id,agenda_definition_id) 

    @agenda_line_items.each { |x| x.agenda = self }

    Assignment.where("meeting_id = ?", @meeting.id).each do |assignment|
      role = Role.find(assignment.role_id)
      member = Member.find(assignment.member_id)
      @roles[role.description] = member.first_name + ' ' +  member.last_name
    end
  end 


  def set_times_for_this_meeting(meeting_id,agenda_definition_id) 
    timer = RunningTime.new(@meeting.hour, @meeting.minute, @meeting.am_pm) 
    first = true
    offset = 1
    @agenda_line_items.each do |line_item|
      if line_item.include_in_agenda == 'Yes'
        line_item.start_time = timer.to_s
        timer + (line_item.duration_in_minutes + offset)
        if first
          first = false
          offset = 0
        end
      else
        line_item.start_time = 'Excluded'
      end
      line_item.save
    end
  end

  def meeting_date
    @meeting.meeting_date
  end

  def member_for(role_name)
    scrubbed_role_name = role_name.gsub(/[$][$]/,'')
    result = @roles[scrubbed_role_name]  ?  @roles[scrubbed_role_name] : 'TBD' 
    result
  end


  def resolved_line_item_text (line_item_text)
    @roles.each do |role, role_text| 
      line_item_text.gsub!(/[$][$]#{role}[$][$]/,role_text)
    end
    line_item_text.gsub!(/[$][$][[:print:]]{1,}[$][$]/, 'TBD')
    line_item_text
  end



  def resolved_line_item_head (line_item_head)
    @roles.each do |role, role_text| 
      line_item_head.gsub!(/[$][$]#{role}[$][$]/,role_text)
    end
    line_item_head.gsub!(/[$][$][[:print:]]{1,}[$][$]/, 'TBD')
    line_item_head
  end


  def agenda_top
    @agenda_top
  end

  def agenda_bottom
    @agenda_bottom
  end



  def agenda_line_items
    @agenda_line_items
  end

  def self.all_required_elements_created_for? club
    default_agenda_def_id = club.default_agenda_definition_id
    AgendaTop.where( :agenda_definition_id => default_agenda_def_id).count == 1 && AgendaLineItem.where(:agenda_definition_id => default_agenda_def_id).count > 0
  end



end












