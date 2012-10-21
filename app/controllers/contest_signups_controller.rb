class ContestSignupsController < ApplicationController
  # GET /contest_signups
  # GET /contest_signups.json
  

  layout  'contest_signup'



  def index
    #@club = current_club
    @contest_signups = ContestSignup.where("club_id = ?", @club.id).order("role_description")
    render :index
  end 
    

  # GET /contest_signups/1
  # GET /contest_signups/1.json
  def show
    @contest_signup = ContestSignup.find(params[:id])
    #@club = current_club
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contest_signup }
    end
  end

  # GET /contest_signups/new
  # GET /contest_signups/new.json
  def new
    @contest_signup = ContestSignup.new
    #@club = current_club
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contest_signup }
    end
  end



  # GET /contest_signups/1/edit
  def signup

    #club = current_club

    @contest_signup = ContestSignup.find(params[:format])
    
    @contest_signup.member_id = current_member.id
    if @contest_signup.save
       redirect_to contest_signups_url 
    end
  end

  # GET /contest_signups/1/edit
  def remove

    #club = current_club

    @contest_signup = ContestSignup.find(params[:format])
    
    @contest_signup.member_id = nil
    if @contest_signup.save
       redirect_to contest_signups_url 
    end
  end

  # GET /contest_signups/1/edit
  def edit
    #@club = current_club
    @contest_signup = ContestSignup.find(params[:id])
   
    if @contest_signup.save
      respond_to do |format|
        format.html  
        format.json { head :no_content }
      end
    end
  end

  # POST /contest_signups
  # POST /contest_signups.json
  def create
    @contest_signup = ContestSignup.new(params[:contest_signup])
    #@club = current_club
    @contest_signup.club_id = @club.id
    respond_to do |format|
      if @contest_signup.save
        format.html { redirect_to contest_signups_path(@contest_signup), notice: 'Contest signup was successfully created.' }
        format.json { render json: @contest_signup, status: :created, location: @contest_signup }
      else
        format.html { render action: "new" }
        format.json { render json: @contest_signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contest_signups/1
  # PUT /contest_signups/1.json
  def update
    #@club = current_club
    @contest_signup = ContestSignup.find(params[:id])
    params[:contest_signup][:member_id] = current_member.id
    respond_to do |format|
      if @contest_signup.update_attributes(params[:contest_signup])
        format.html { redirect_to contest_signups_path(@contest_signup), notice: 'Contest signup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contest_signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contest_signups/1
  # DELETE /contest_signups/1.json
  def destroy
    @contest_signup = ContestSignup.find(params[:id])
    @contest_signup.destroy

    respond_to do |format|
      format.html { redirect_to contest_signups_url }
      format.json { head :no_content }
    end
  end
end
