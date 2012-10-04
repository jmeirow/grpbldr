class MeetingsController < ApplicationController
  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.where("club_id = ? and meeting_date >= ?", params[:club_id], Date.today).order("meeting_date").page(params[:page]).per(7)
    @club = current_club

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetings }
    end
  end
  
  
  # GET /meetings
  # GET /meetings.json
  def forassignment
    @meetings = Meeting.needing_assignments params[:club_id]
    render :layout => 'admins' 
  end
  

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    @meeting_notes = MeetingNote.where("meeting_id = ?", params[:id])

    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.json
  def new
    @club = current_club
    @meeting = Meeting.new

   


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = Meeting.find(params[:id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(params[:meeting])
    @meeting.club_id = params[:club_id]
    meeting_date = @meeting.meeting_date.strftime("%m/%d/%Y") if @meeting.meeting_date
    
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to  new_club_meeting_path(params[:club_id]), notice: "Meeting #{meeting_date} for was successfully created." }
        format.json { render json: @meeting, status: :created, location: @meeting }
         
      else
        format.html { render action: "new" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
         
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.json
  def update
    @meeting = Meeting.find(params[:id])
    
    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to club_meeting_path(params[:club_id],@meeting), notice: 'Meeting was successfully updated.' }
        format.json { head :ok }
        
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
          
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to club_meetings_path(params[:club_id]) }
      format.json { head :ok }
    end
  end


  def print

    @agenda = Agenda.new(params[:meeting_id], 0)

     render :layout => 'agendas'  
  end

  def print_notes_setup

  end

  def print_notes
     @meeting_notes = MeetingNote.where("meeting_id = ?", params[:meeting_id])
     @meeting = Meeting.find(params[:meeting_id])
     render :layout => 'agendas'  
  end




  
end
