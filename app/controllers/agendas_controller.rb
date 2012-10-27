class AgendasController < ApplicationController
  



  def print

  	@agenda = Agenda.new(params[:id], 0)
    get_role_names
  	respond_to do |format|
      format.html   
    end
  end


    


  def show 

    #@club = current_club
  	@agenda = Agenda.new(params[:meeting_id],params[:agenda_definition_id])
    @meeting = Meeting.find(params[:meeting_id])
    @next_meeting = @meeting.next_meeting
    @meeting_agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
    get_role_names
  	respond_to do |format|
      format.html   
    end
  end



  def get_role_names
       
      @roles = Hash.new

      Assignment.where("meeting_id = ?", @meeting.id).each do |assignment|
        role = Role.find(assignment.role_id)
        member = Member.find(assignment.member_id)
        @roles[role.description] = member.first_name + ' ' +  member.last_name
      end
    end
























 
end
