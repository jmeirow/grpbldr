

class RolesController < ApplicationController
  # GET /roles
  # GET /roles.json

  layout  'admins'

  def index
    #@club = current_club
    @roles = Role.where("club_id = ?", params[:club_id]).page(params[:page]).per(7)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @role = Role.find(params[:id])
     #@club = current_club
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.json
  def new
    @role = Role.new
     #@club = current_club
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role }
    end
  end

  # POST /roles
  # POST /roles.json
  def create
    #@club = current_club

    @role = Role.new(params[:role])
    @role.club_id = params[:club_id]

    respond_to do |format|
      if @role.save
        Role.refresh_role_meeting_types(@role.id,params)
        format.html { redirect_to club_role_path(params[:club_id],@role), notice: 'Role was successfully created.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render action: "new" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /roles/1/edit
  def edit
    #@club = current_club
    @role = Role.find(params[:id])
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    @club = current_club

    @role = Role.find(params[:id])
    
    if @role.update_attributes(params[:role])
      Role.refresh_role_meeting_types(@role.id,params)
      redirect_to club_roles_path(@club, notice: 'Role was successfully updated.')
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    #@club = current_club
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to club_roles_path(params[:club_id]) }
      format.json { head :ok }
    end
  end


  private 




end
