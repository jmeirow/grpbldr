 


class AgendaDefinitionsController < ApplicationController

  layout  'admins'


  def index
    @agenda_definitions = AgendaDefinition.where("club_id = ?", @club.id)
  end

 
  def show
    @agenda_definition = AgendaDefinition.find(params[:id])
    @agenda_bottom = AgendaBottom.where(" agenda_definition_id = ? ",@agenda_definition.id).first
    get_agenda_top_link(@agenda_top_link,@agenda_top_link_text)
    get_agenda_bottom_link(@agenda_bottom_link,@agenda_bottom_link_text)
  end


  def new
    @agenda_definition = AgendaDefinition.new
    @agenda_definition.name = @agenda_definition.description
    @available_meeting_types  = available_meeting_types_for_new_action
    if params[:meeting_type_id]
      @meeting_type_id = params[:meeting_type_id].to_i
    end
  end



  def edit
    @agenda_definition = AgendaDefinition.find(params[:id].to_i)
    @available_meeting_types  = available_meeting_types_for_edit_action
    @meeting_type_id = @agenda_definition.meeting_type_id
  end


  def create
    @agenda_definition = AgendaDefinition.new(params[:agenda_definition])
    @meeting_type = MeetingType.find(params[:agenda_definition][:meeting_type_id].to_i)
    @agenda_definition.name = @meeting_type.description
    @agenda_definition.club_id = @club.id
    if @agenda_definition.save
      redirect_to club_agenda_definition_path(@club,@agenda_definition), notice: 'Agenda definition was successfully created.'  
    else
       render action: "new"  
    end
  end


  def update
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition][:id])
    @meeting_type = MeetingType.find(params[:agenda_definition][:meeting_type_id].to_i)
    @agenda_definition.name = @meeting_type.description
    if @agenda_definition.update_attributes(params[:agenda_definition])
      redirect_to club_agenda_definition_path(@club,@agenda_definition), notice: 'Agenda definition was successfully updated.'  
    else
       render action: "edit" 
    end
  end


  def destroy
    @agenda_definition = AgendaDefinition.find(params[:id])
    @agenda_definition.destroy
    @club
    redirect_to club_agenda_definitions_path(params[:club_id])  
  end

   
  def get_agenda_top_link(link,text)
    @agenda_definition  = AgendaDefinition.find(params[:id])
    @agenda_top = AgendaTop.where(" agenda_definition_id = ? ",@agenda_definition.id).first
    @agenda_top_link = @agenda_top.nil?  ?
     new_club_agenda_definition_agenda_top_path(@club,@agenda_definition ) : edit_club_agenda_definition_agenda_top_path(@club,@agenda_definition,@agenda_top)
    @agenda_top_link_text = @agenda_top.nil?  ? "Create Agenda Top" : "Edit Agenda Top"
  end


  def get_agenda_bottom_link(link,text)
    @agenda_definition  = AgendaDefinition.find(params[:id])
    @agenda_bottom = AgendaBottom.where(" agenda_definition_id = ? ",@agenda_definition.id).first
    @agenda_bottom_link = @agenda_bottom.nil?  ?
    new_club_agenda_definition_agenda_bottom_path(@club,@agenda_definition ) : edit_club_agenda_definition_agenda_bottom_path(@club,@agenda_definition,@agenda_bottom)
    @agenda_bottom_link_text = @agenda_bottom.nil?  ? "Create Agenda Bottom" : "Edit Agenda Bottom"
  end


  def include_all_lines
    @agenda_definition  = AgendaDefinition.find(params[:agenda_definition_id])
    AgendaLineItem.update_all({:include_in_agenda => 'Yes'}, {:agenda_definition_id => params[:agenda_definition_id]})
    redirect_to  club_agenda_definition_agenda_line_items_path(@club,@agenda_definition), notice: 'All line items now included on agenda.'  

  end

  def meeting_types_with_agendas
    AgendaDefinition.where("club_id = ? ", params[:club_id]).map { |x| x.meeting_type_id }
  end


  def available_meeting_types_for_new_action
    meeting_type_ids = MeetingType.where("club_id = ? and id not in (?)", params[:club_id], meeting_types_with_agendas).each { |x| x.id }
    if params[:meeting_type_id]
      meeting_type_ids << params[:meeting_type_id].to_i 
    end
    MeetingType.where("id in (?)", meeting_type_ids   ) 
  end


  def available_meeting_types_for_edit_action
    meeting_type_id_for_selected = AgendaDefinition.find(params[:id].to_i).meeting_type_id
    meeting_type_ids = (MeetingType.where("club_id = ? and id not in (?)", params[:club_id], meeting_types_with_agendas).map { |x| x.id }  + [meeting_type_id_for_selected] )
    MeetingType.where("id in (?)", meeting_type_ids   ) 
  end

end