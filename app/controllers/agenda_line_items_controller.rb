require 'custom/running_time.rb'

class AgendaLineItemsController < ApplicationController

  layout  'admins'
  
  
 

  # GET /agenda_line_items
  # GET /agenda_line_items.json

  def index
    
    @agenda_line_items = AgendaLineItem.where("agenda_definition_id = ?", params[:agenda_definition_id]).order("sequence_nbr asc")
    #@club = current_club
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])


    next_meeting = @club.next_meeting

    
    timer = RunningTime.new(next_meeting.hour,next_meeting.minute, next_meeting.am_pm) 


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




  # GET /agenda_line_items/1
  # GET /agenda_line_items/1.json
  def show
    @agenda_line_item = AgendaLineItem.where("id = ?",params[:id]).first
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
    #@club = current_club
 end

  # GET /agenda_line_items/new
  # GET /agenda_line_items/new.json
  def new
    init
    @agenda_line_item = AgendaLineItem.new
    @agenda_line_item.sequence_nbr = @next_sequence_nbr
    @agenda_line_item.agenda_definition_id = @agenda_definition.id
  end

  # GET /agenda_line_items/1/edit
  def edit
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id]) 
    @agenda_line_item = AgendaLineItem.find(params[:id])
    @agenda_line_item.agenda_definition_id = @agenda_definition.id
    #@club = current_club
    @roles = Role.where("club_id = ?", @club.id).order("description asc")
    @leaders = Leader.where("club_id = ?", @club.id).order("title asc")


  end

  # POST /agenda_line_items
  # POST /agenda_line_items.json
  def create
    
    #@club = current_club
    @agenda_line_item = AgendaLineItem.new(params[:agenda_line_item])
    @agenda_line_item.agenda_definition_id = params[:agenda_definition_id]
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id]) 
    @roles = Role.where("club_id = ?", @club.id).order("description asc")

    if @agenda_line_item.save
       redirect_to  club_agenda_definition_agenda_line_item_path(@club,@agenda_definition,@agenda_line_item), :method => :get, notice: 'Agenda Line Item was successfully created.'  
    else
      init 
      render action: "new"  
    end
  end

  # PUT /agenda_line_items/1
  # PUT /agenda_line_items/1.json
  def update
     
    @agenda_line_item = AgendaLineItem.where("id = ? ", params[:id]).first
    #@club = current_club
    @agenda_definition = AgendaDefinition.find(@agenda_line_item.agenda_definition_id)

    if @agenda_line_item.update_attributes(params[:agenda_line_item])
      redirect_to  club_agenda_definition_agenda_line_item_path(@club,@agenda_definition,@agenda_line_item), :method => :get, notice: 'Agenda Line Item was successfully updated.'  
    else
      render action: "edit"
    end
  end

  # DELETE /agenda_line_items/1
  # DELETE /agenda_line_items/1.json
  def destroy
    @agenda_line_item = AgendaLineItem.find(params[:id])
    @agenda_definition = AgendaDefinition.find(@agenda_line_item.agenda_definition_id)
    @agenda_line_item.destroy

    respond_to do |format|
      format.html { redirect_to club_agenda_definition_agenda_line_items_path(@club,@agenda_definition) }
      format.json { head :no_content }
    end
  end

  def sort 
    params[:agenda_line_item].each_with_index do |id, index|
      AgendaLineItem.update_all({sequence_nbr: index+1, start_time: ''}, id: id   )
    end
 end


 def toggle_inclusion

     
    line_item = AgendaLineItem.find(params[:agenda_line_item_id])
    line_item.toggle_inclusion
    line_item.save

    #@club = current_club
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id])
    @agenda_line_items= AgendaLineItem.where("agenda_definition_id = ?", params[:agenda_definition_id])

    redirect_to club_agenda_definition_agenda_line_items_path(@club,@agenda_definition)

  end


  private

  def init
    @next_sequence_nbr = AgendaLineItem.where("agenda_definition_id = ?",params[:agenda_definition_id]).maximum("sequence_nbr")
    @next_sequence_nbr = @next_sequence_nbr.nil? ? 0 : @next_sequence_nbr  + 1
    @agenda_definition = AgendaDefinition.find(params[:agenda_definition_id]) 
    #@club = current_club
    @roles = Role.where("club_id = ?", @club.id).order("description asc")
    @leaders = Leader.where("club_id = ?", @club.id).order("title asc")
  end



end
