class AgendaDefinitionsController < ApplicationController
  # GET /agenda_definitions
  # GET /agenda_definitions.json

  layout  'admins'



  def index
    #@club = current_club

    @agenda_definitions = AgendaDefinition.where("club_id = ?", @club.id)
    
  end

  # GET /agenda_definitions/1
  # GET /agenda_definitions/1.json
  def show
    @agenda_definition = AgendaDefinition.find(params[:id])
    @agenda_bottom = AgendaBottom.where(" agenda_definition_id = ? ",@agenda_definition.id).first
    #@club = current_club
    get_agenda_top_link(@agenda_top_link,@agenda_top_link_text)
    get_agenda_bottom_link(@agenda_bottom_link,@agenda_bottom_link_text)
    
  end

  # GET /agenda_definitions/new
  # GET /agenda_definitions/new.json
  def new
    @agenda_definition = AgendaDefinition.new
    #@club = current_club
  end

  # GET /agenda_definitions/1/edit
  def edit
    
    @agenda_definition = AgendaDefinition.find(params[:id])
    #@club = current_club
  end

  # POST /agenda_definitions
  # POST /agenda_definitions.json
  def create
    @agenda_definition = AgendaDefinition.new(params[:agenda_definition])
    #@club = current_club
    @agenda_definition.club_id = @club.id
    if @agenda_definition.save
      redirect_to club_agenda_definition_path(@club,@agenda_definition), notice: 'Agenda definition was successfully created.'  
    else
       render action: "new"  
    end
  end

  # PUT /agenda_definitions/1
  # PUT /agenda_definitions/1.json
  def update
    #@club = current_club
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition][:id])
    if @agenda_definition.update_attributes(params[:agenda_definition])
      redirect_to club_agenda_definition_path(@club,@agenda_definition), notice: 'Agenda definition was successfully updated.'  
    else
       render action: "edit" 
    end
  end

  # DELETE /agenda_definitions/1
  # DELETE /agenda_definitions/1.json
  def destroy
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition][:id])
    @agenda_definition.destroy
    @club
    redirect_to agenda_definitions_url  
  end


   
  def get_agenda_top_link(link,text)
    #@club = current_club
    
    @agenda_definition  = AgendaDefinition.find(params[:id])
    @agenda_top = AgendaTop.where(" agenda_definition_id = ? ",@agenda_definition.id).first
    @agenda_top_link = @agenda_top.nil?  ?
     new_club_agenda_definition_agenda_top_path(@club,@agenda_definition ) : edit_club_agenda_definition_agenda_top_path(@club,@agenda_definition,@agenda_top)
    @agenda_top_link_text = @agenda_top.nil?  ? "Create Agenda Top" : "Edit Agenda Top"
  end

  def get_agenda_bottom_link(link,text)
    #@club = current_club
    
    @agenda_definition  = AgendaDefinition.find(params[:id])
    @agenda_bottom = AgendaBottom.where(" agenda_definition_id = ? ",@agenda_definition.id).first
    @agenda_bottom_link = @agenda_bottom.nil?  ?
    new_club_agenda_definition_agenda_bottom_path(@club,@agenda_definition ) : edit_club_agenda_definition_agenda_bottom_path(@club,@agenda_definition,@agenda_bottom)
    @agenda_bottom_link_text = @agenda_bottom.nil?  ? "Create Agenda Bottom" : "Edit Agenda Bottom"
  end


  def include_all_lines
    #@club = current_club
    @agenda_definition  = AgendaDefinition.find(params[:agenda_definition_id])
    AgendaLineItem.update_all({:include_in_agenda => 'Yes'}, {:agenda_definition_id => params[:agenda_definition_id]})
    redirect_to  club_agenda_definition_agenda_line_items_path(@club,@agenda_definition), notice: 'All line items now included on agenda.'  

  end


end