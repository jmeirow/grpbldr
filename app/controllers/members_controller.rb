

class MembersController < ApplicationController
  # GET /members
  # GET /members.json





  def index
  
    @members = Member.where("club_id = ?", params[:club_id]).order("last_name, first_name").page(params[:page]).per(7)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show

    @member = Member.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new
     

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])
    @member.club_id = params[:club_id]
    respond_to do |format|
      if @member.save
        #Member.send_mail(@member)
        format.html { redirect_to club_member_path(params[:club_id],@member), notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @club = current_club

    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        @member.event.transacted_by = current_member.full_name
        @member.event.club_id = session[:club_id]
        @member.event.save
        format.html { redirect_to club_member_path(params[:club_id],@member), notice: 'Member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to club_members_path(params[:club_id]) }
      format.json { head :ok }
    end
  end
end
