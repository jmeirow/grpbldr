



class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.json

  layout 'admin', :only => [:signup_for_role_multi_club]

  def index
    @assignments = Assignment.includes(:meeting).where("member_id = ? and meetings.meeting_date >= ?", params[:member_id], Date.today).order("meeting_date").page(params[:page]).per(7)
    @member = Member.find(params[:member_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end
  


def past_activity
    @assignments = Assignment.includes(:meeting).where("member_id = ? and meetings.meeting_date < ?", params[:member_id], Date.today).order("meeting_date").page(params[:page]).per(7)
    @member = Member.find(params[:member_id])
    
    respond_to do |format|
      format.html  # index.html.erb
      format.json { render json: @assignments }
    end
  end
  


  
  def member_assignments
    @assignments = Assignment.where("member_id = ?", params[:member_id], :include => :members)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end
  
  

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(params[:assignment])

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to club_member_assignment_path(params[:club_id], @member,@assignment), notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  

  # PUT /assignments/1
  # PUT /assignments/1.json
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to club_member_assignment_path(params[:club_id], @member,@assignment), notice: 'Assignment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment = Assignment.find(params[:id])
    member = @assignment.member_id
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to club_member_assignments_path(params[:club_id],member) }
      format.json { head :ok }
    end
  end
  
  def generate
    p = AssignmentPolicy.new(params[:meeting_ids], params[:club_id])
    
    @assignments = p.make_assignments   
    render 'club_assignments'
  end
  


  def signup_for_role_multi_club
  
    

    if !params[:filtered_on_free] 

       params[:filtered_on_free] = "0"
    end

    if params[:club]

      params[:club_id] = params[:club][:id]
      member = Member.where("club_id = ? and email = ?", params[:club_id], session[:email]).first
      params[:member_id] = member.id
    end


    @club = Club.find(params[:club_id])
    @clubs = Club.where("id in (?)", session[:clubs])

    @helper = SignupHelper.new params
     

    if SignupHelper.user_has_submitted_request? params
      if @helper.save
        @helper.email 
        #redirect_to club_meetings_path(params[:club_id]) , notice: 'Your requests have been submitted and should appear on the meeting agendas soon.' 
        redirect_to signup_for_role_multi_club_club_member_assignments_path(current_club, current_member),     notice: 'Your requests have been submitted.'   

        return 
      end 
    end

  
    @prior_committments = Assignment.includes(:meeting).where("member_id in (?) and meetings.meeting_date >= ?", session[:members], Date.today) 

    @requested_information = @helper.requested_information 

    @requested_information.each do |item|
      item.prior_committments = @prior_committments.select { |e|  e.meeting.meeting_date == item.meeting.meeting_date  }
    end


    @arr_name = Kaminari.paginate_array(@requested_information).page(params[:page]).per(10)

    respond_to do |format|
      format.html  { render  :layout => 'signup_for_role_multi_club'  }
    end


  end

  def signup_for_role
    
    if !params[:filtered_on_free] 

       params[:filtered_on_free] = "0"
    end
    
    @club = Club.find(params[:club_id])

    @helper = SignupHelper.new params
     

    if SignupHelper.user_has_submitted_request? params
      if @helper.save
        @helper.email 
        #redirect_to club_meetings_path(params[:club_id]) , notice: 'Your requests have been submitted and should appear on the meeting agendas soon.' 
        redirect_to signup_for_role_club_member_assignments_path(params[:club_id], current_member),  notice: 'Your requests have been submitted.' 

        return 
      end 
    end

  
    @prior_committments = Assignment.includes(:meeting).where("member_id = ? and meetings.meeting_date >= ?", params[:member_id], Date.today) 

    @requested_information = @helper.requested_information 

    @requested_information.each do |item|
      item.prior_committments = @prior_committments.select { |e|  e.meeting.meeting_date == item.meeting.meeting_date  }
    end


    @arr_name = Kaminari.paginate_array(@requested_information).page(params[:page]).per(10)

    respond_to do |format|
      format.html
    end

  end

  
end
