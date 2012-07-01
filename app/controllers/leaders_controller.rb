class LeadersController < ApplicationController
  

  layout  'admins'

  # GET /leaders
  # GET /leaders.json
  def index
    @leaders = Leader.where("club_id = ?" , params[:club_id])
    @club = current_club
  end

  # GET /leaders/1
  # GET /leaders/1.json
  def show
    @club = current_club
    @leader = Leader.find(params[:id])
  end

  # GET /leaders/new
  # GET /leaders/new.json
  def new
    @leader = Leader.new
    @club = current_club
 
  end

  # GET /leaders/1/edit
  def edit
    @club = current_club
    @leader = Leader.find(params[:id])
  end

  # POST /leaders
  # POST /leaders.json
  def create
    @leader = Leader.new(params[:leader])
     @club = current_club
     @leader.club_id = @club.id
    respond_to do |format|
      if @leader.save
        format.html { redirect_to club_leader_path(@club,@leader), notice: 'Leader was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /leaders/1
  # PUT /leaders/1.json
  def update
    @leader = Leader.find(params[:id])
    @club = current_club
    respond_to do |format|
      if @leader.update_attributes(params[:leader])
        format.html { redirect_to club_leader_path(@club,@leader),  notice: 'Leader was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /leaders/1
  # DELETE /leaders/1.json
  def destroy
    @leader = Leader.find(params[:id])
    @leader.destroy
     @club = current_club
    respond_to do |format|
      format.html { redirect_to club_leaders_url }

    end
  end
end



























