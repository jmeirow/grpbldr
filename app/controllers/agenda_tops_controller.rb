class AgendaTopsController < ApplicationController



  layout  'admins'


  # GET /agenda_tops
  # GET /agenda_tops.json
  def index
    @agenda_top = AgendaTop.where("agenda_definition_id = ?", params[:adenda_definition_id]).first
    #@club = current_club
  end

  # GET /agenda_tops/1
  # GET /agenda_tops/1.json
  def show
    #@club = current_club
    @agenda_top = AgendaTop.where("agenda_definition_id = ?",params[:agenda_definition_id]  ).first
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
    if @agenda_top.nil?
      @agenda_top = AgendaTop.new
      redirect_to 'new'
    end

 
  end

  # GET /agenda_tops/new
  # GET /agenda_tops/new.json
  def new
    #@club = current_club
    @agenda_top = AgendaTop.new
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
  end

  # GET /agenda_tops/1/edit
  def edit
    #@club = current_club
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
    @agenda_top = AgendaTop.find(params[:id])
  end

  # POST /agenda_tops
  # POST /agenda_tops.json
  def create
     
    #@club = current_club
    @agenda_top = AgendaTop.new(params[:agenda_top])
    @agenda_top.agenda_definition_id = params[:agenda_definition_id]
    if @agenda_top.save
        redirect_to  club_agenda_definition_agenda_top_path(@club,params[:agenda_definition_id],@agenda_top), :method => :get, notice: 'Agenda Top Section was successfully created.'  
    else
        render action: "new" 
    end
  end




  # PUT /agenda_tops/1
  # PUT /agenda_tops/1.json
  def update

    #@club = current_club
    @agenda_top = AgendaTop.find(params[:id])
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
   if @agenda_top.update_attributes(params[:agenda_top])
      redirect_to club_agenda_definition_agenda_top_path(@club,@agenda_definition,@agenda_top), notice: 'Agenda Top Section was successfully updated.' 
    else
       render action: "edit"  
    end
 
  end

  # DELETE /agenda_tops/1
  # DELETE /agenda_tops/1.json
  def destroy
    #@club = current_club
    @agenda_top = AgendaTop.find(params[:id])
    @agenda_top.destroy

    respond_to do |format|
       redirect_to club_agenda_definition_agenda_tops_url 
    end
  end





end



