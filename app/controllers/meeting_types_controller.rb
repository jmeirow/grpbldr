class MeetingTypesController < ApplicationController
  
 layout  'admins'



  def index
    @meeting_types = get_meeting_types_index
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show
    @meeting_type = MeetingType.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def new
    init_drop_down_values
    @meeting_type = MeetingType.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end


  def edit
    init_drop_down_values
    @meeting_type = MeetingType.find(params[:id])
  end

   
  def create
    @meeting_type = MeetingType.new(params[:meeting_type])
    @meeting_type.meeting_time = params[:meeting_type][:meeting_time]
    @meeting_type.is_default = false 
    @meeting_type.club_id = params[:club_id]
    

    
    if @meeting_type.save
      @show_agenda_def_link = true
      @meeting_types = get_meeting_types_index
      @new_meeting_type_id = @meeting_type.id
      @meeting_type_description = @meeting_type_description
      flash[:notice] =  'Meeting Type successfully created.'  
      render 'index' 
    else
      format.html { render action: "new" }
    end
    
  end


  def update
    @meeting_type = MeetingType.find(params[:id])
    @meeting_type.meeting_time = params[:meeting_type][:meeting_time]
    @show_agenda_def_link = false
    respond_to do |format|
      if @meeting_type.update_attributes(params[:meeting_type])
        format.html { redirect_to club_meeting_types_path (@club), notice: 'Meeting Type successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end


  def destroy
    @meeting_type = MeetingType.find(params[:id])
    @meeting_type.destroy
    respond_to do |format|
      format.html { redirect_to club_meeting_types_url }
    end
  end





  private  


  def get_meeting_types_index
     MeetingType.where("club_id = ?", @club.id).order('is_default desc, description asc')
  end

  def init_drop_down_values
    @minutes = Array.new
    @hours =    [%w(1 1), %w(2 2), %w(3 3), %w(4 4), %w(5 5), %w(6 6), %w(7 7)  , %w(8 8), %w(9 9), %w(10 10), %w(11 11), %w(12 12) ]
    @minutes =  [%w(00 0), %w(05 5), %w(10 10), %w(15 15), %w(20 20), %w(25 25), %w(30 30), %w(35 35), %w(40 40),%w(45 45), %w(50 50), %w(55 55)] 
    @am_pm =    [%w(AM AM), %w(PM PM) ]
  end



end
