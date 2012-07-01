class Agenda









  def initialize(meeting_id, agenda_definition_id)

 
      @meeting = Meeting.find(meeting_id)
      @roles = Hash.new
      if !agenda_definition_id.nil? && agenda_definition_id.to_i > 0
        @agenda_top = AgendaTop.where(" agenda_definition_id = ?", agenda_definition_id).first
        @agenda_bottom = AgendaBottom.where(" agenda_definition_id = ?", agenda_definition_id).first
        @agenda_line_items = AgendaLineItem.where(" agenda_definition_id = ? and include_in_agenda = ?", agenda_definition_id, 'Yes').order("sequence_nbr asc")
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
     
    result = @roles[role_name]
    result = 'TBD' if result.nil?
    result
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












