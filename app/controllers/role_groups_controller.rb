class RoleGroupsController < ApplicationController
  

  layout  'admins'

  # GET /role_groups
  # GET /role_groups.json



  def index
    
    @role_groups = RoleGroup.where("club_id = ?", params[:club_id])
    @roles = Role.where("club_id = ?", params[:club_id]) 


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @role_groups }
    end
  end

  # GET /role_groups/1
  # GET /role_groups/1.json
  def show
    @role_group = RoleGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @role_group }
    end
  end

  # GET /role_groups/new
  # GET /role_groups/new.json
  def new
    @role_group = RoleGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role_group }
    end
  end

  # GET /role_groups/1/edit
  def edit
    @role_group = RoleGroup.find(params[:id])
  end

  # POST /role_groups
  # POST /role_groups.json
  def create
    @role_group = RoleGroup.new(params)

    respond_to do |format|
      if @role_group.save

      params[:role][:role_ids].each do |role_id|
        assoc = RoleGroupAssociation.new
        assoc.role_id = role_id
        assoc.role_group_id = @role_group.id
        assoc.club_id = params[:club_id]
        assoc.save
      end



        format.html { redirect_to club_role_groups_path, notice: 'Role group was successfully created.' }
        #format.json { render json: @role_group, status: :created, location: @role_group }
      else
        format.html { redirect_to club_role_groups_path, notice: 'An error occurred. Changes not saved.'  }
        #format.json { render json: @role_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /role_groups/1
  # PUT /role_groups/1.json
  def update
    @role_group = RoleGroup.find(params[:id])

    respond_to do |format|
      if @role_group.update_attributes(params[:role_group])

        format.html { redirect_to @role_group, notice: 'Role group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @role_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_groups/1
  # DELETE /role_groups/1.json
  def destroy
    @role_group = RoleGroup.find(params[:id])
    @role_group.destroy

    respond_to do |format|
      format.html { redirect_to role_groups_url }
      format.json { head :no_content }
    end
  end
end
