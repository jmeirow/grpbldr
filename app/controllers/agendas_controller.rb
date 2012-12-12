

class AgendasController < ApplicationController
  # def print

  # 	@agenda = Agenda.new(params[:id], 0)
  #   get_role_names
  # 	respond_to do |format|
  #     format.html   
  #   end
  # end


    


  def show 

 

    if !Agenda.all_required_elements_created_for? current_club
      @agenda_definition = AgendaDefinition.find(@club.default_meeting_type_id) 
      flash[:notice] = "An agenda has not yet been defined. Create an 'Agenda Top' and one or more 'Agenda Line Items'."
      redirect_to club_agenda_definition_path @club, @agenda_definition
    else
    	@agenda = Agenda.new(params[:meeting_id].to_i,params[:agenda_definition_id].to_i)
      @meeting = Meeting.find(params[:meeting_id])
      @meeting_agenda_definition = AgendaDefinition.find(params[:agenda_definition_id].to_i)
      get_role_names
    	respond_to do |format|
        format.html   
      end
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
