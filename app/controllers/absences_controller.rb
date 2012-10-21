class AbsencesController < ApplicationController
  # GET /absences
  # GET /absences.json
  def index
    @absences = Absence.where("member_id = ?",params[:member_id]).order("start_date DESC").page(params[:page]).per(7)
    @member = Member.find(params[:member_id])
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @absences }
    end
  end


  # GET /club/:club_id/absences
  def list
    @absences = Absence.where("member_id in (?)",Member.where("club_id = ?",params[:club_id])).order("start_date DESC").page(params[:page]).per(7)
  end
  

  # GET /absences/1
  # GET /absences/1.json
  def show
    @absence = Absence.find(params[:id])
    @member = Member.find(params[:member_id])
    
     

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @absence }
    end
  end

  # GET /absences/new
  # GET /absences/new.json
  def new
    @absence = Absence.new
    @member = Member.find(params[:member_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @absence }
    end
  end

  # GET /absences/1/edit
  def edit
    @absence = Absence.find(params[:id])
    @member = Member.find(params[:member_id])
  end

  # POST /absences
  # POST /absences.json
  def create
    @absence = Absence.new(params[:absence])
    @absence.member_id = params[:member_id]
    @member = Member.find(params[:member_id])
    @club = Club.find(params[:club_id] )   

    respond_to do |format|
      if @absence.save
        format.html { redirect_to club_member_absence_path(@club,@member,@absence), notice: 'Absence was successfully created.' }
        format.json { render json: @absence, status: :created, location: @absence }
      else
        format.html { render action: "new" }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /absences/1
  # PUT /absences/1.json
  def update
    @absence = Absence.find(params[:id])
    #@member = Member.find(params[:member_id])
    #@club = Club.find(params[:club_id] )   

 
        

    respond_to do |format|
      if @absence.update_attributes(params[:absence])
        format.html { redirect_to club_member_absence_path(@club,@member,@absence), notice: 'Absence was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /absences/1
  # DELETE /absences/1.json
  def destroy
    @absence = Absence.find(params[:id])
    @absence.destroy

    respond_to do |format|
      format.html { redirect_to club_member_absences_path(params[:club_id],current_member) }
      format.json { head :ok }
    end
  end
end
