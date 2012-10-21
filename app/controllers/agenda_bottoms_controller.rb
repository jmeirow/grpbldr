class AgendaBottomsController < ApplicationController


  layout  'admins'


  # GET /agenda_tops
  # GET /agenda_tops.json
  def index
    #@club = current_club
    @agenda_top = AgendaTop.where("agenda_definition_id = ?", params[:adenda_definition_id]).first
  end

  # GET /agenda_bottoms/1
  # GET /agenda_bottoms/1.json
  def show
    #@club = current_club
    @agenda_bottom = AgendaBottom.where("agenda_definition_id = ?",params[:agenda_definition_id]  ).first
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
    if @agenda_bottom.nil?
      @agenda_bottom = AgendaBottom.new
      redirect_to 'new'
    end
  end

  # GET /agenda_bottoms/new
  # GET /agenda_bottoms/new.json
  def new
    #@club = current_club
    @agenda_bottom = AgendaBottom.new
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
    @agenda_bottom.agenda_definition_id = @agenda_definition.id
  end

  # GET /agenda_bottoms/1/edit
  def edit
    #@club = current_club
    @agenda_bottom = AgendaBottom.where("agenda_definition_id = ?",params[:agenda_definition_id]  ).first
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
  end

  # POST /agenda_bottoms
  # POST /agenda_bottoms.json
  def create
    #@club = current_club
    @agenda_bottom = AgendaBottom.new(params[:agenda_bottom])
    @agenda_definition = AgendaDefinition.find(params[:agenda_bottom][:agenda_definition_id])
    if @agenda_bottom.save
        redirect_to  club_agenda_definition_agenda_bottom_path(@club,@agenda_definition,@agenda_bottom), :method => :get, notice: 'Agenda Bottom Section was successfully created.'  
    else
        render action: "new" 
    end
  end

  # PUT /agenda_bottoms/1
  # PUT /agenda_bottoms/1.json
  def update
    #@club = current_club
    @agenda_bottom = AgendaBottom.find(params[:id])
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
     if @agenda_bottom.update_attributes(params[:agenda_bottom])
       redirect_to club_agenda_definition_agenda_bottom_path(@club,@agenda_definition,@agenda_bottom), notice: 'Agenda Top Section was successfully updated.' 
    else
       render action: "edit"  
    end
  end




  # DELETE /agenda_bottoms/1
  # DELETE /agenda_bottoms/1.json
  def destroy
    #@club = current_club
    @agenda_bottom = AgendaBottom.find(params[:id])
    @agenda_bottom.destroy
    redirect_to club_agenda_definition_agenda_bottoms_url 
  end
end
