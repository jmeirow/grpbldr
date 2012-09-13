class MeetingTypesController < ApplicationController
  # GET /meeting_types
  # GET /meeting_types.json
  
 layout  'admins'


  def index
    @club = current_club
    @meeting_types = MeetingType.where("club_id = ?", @club.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meeting_types }
    end
  end

  # GET /meeting_types/1
  # GET /meeting_types/1.json
  def show
    @club = current_club
    @meeting_type = MeetingType.find(params[:id])
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting_type }
    end
  end

  # GET /meeting_types/new
  # GET /meeting_types/new.json
  def new
    @meeting_type = MeetingType.new
    @club = current_club
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting_type }
    end
  end

  # GET /meeting_types/1/edit
  def edit
    @club = current_club
    @meeting_type = MeetingType.find(params[:id])
  end

  # POST /meeting_types
  # POST /meeting_types.json
  def create
    @meeting_type = MeetingType.new(params[:meeting_type])
    @club = current_club
    @meeting_type.club_id = params[:club_id]
    respond_to do |format|
      if @meeting_type.save
        format.html { redirect_to club_meeting_type_path(@club,@meeting_type), notice: 'Meeting type was successfully created.' }
        format.json { render json: @meeting_type, status: :created, location: @meeting_type }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meeting_types/1
  # PUT /meeting_types/1.json
  def update
    @meeting_type = MeetingType.find(params[:id])
    @club = current_club
    respond_to do |format|
      if @meeting_type.update_attributes(params[:meeting_type])
        format.html { redirect_to @meeting_type, notice: 'Meeting type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_types/1
  # DELETE /meeting_types/1.json
  def destroy
    @club = current_club
    @meeting_type = MeetingType.find(params[:id])
    @meeting_type.destroy

    respond_to do |format|
      format.html { redirect_to meeting_types_url }
      format.json { head :no_content }
    end
  end
end
