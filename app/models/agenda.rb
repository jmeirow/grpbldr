class Agenda









  def initialize(meeting_id, agenda_definition_id)

 
      @meeting = Meeting.find(meeting_id)
      @roles = Hash.new
      if !agenda_definition_id.nil? && agenda_definition_id.to_i > 0
        @agenda_top = AgendaTop.where(" agenda_definition_id = ?", agenda_definition_id).first
        @agenda_bottom = AgendaBottom.where(" agenda_definition_id = ?", agenda_definition_id).first
        @agenda_line_items = AgendaLineItem.where(" agenda_definition_id = ? and include_in_agenda = ?", agenda_definition_id, 'Yes').order("sequence_nbr asc")
        @agenda_line_items.each { |x| x.agenda = self }
      end

      Assignment.where("meeting_id = ?", @meeting.id).each do |assignment|
        role = Role.find(assignment.role_id)
        member = Member.find(assignment.member_id)
        @roles[role.description] = member.first_name + ' ' +  member.last_name
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












end












