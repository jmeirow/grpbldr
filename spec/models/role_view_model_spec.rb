



describe "this is a test" do  
  # it "should exist" do  

  #   role_view_model = RoleViewModel.new




  # end
end


=begin   


  OLD WAY

  # GET /roles/1/edit
  def edit
    #@club = current_club
    @role = Role.find(params[:id])
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    #@club = current_club

    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to club_roles_path(params[:club_id]), notice: 'Role was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end



  NEW WAY



  # GET /roles/1/edit
  def correct_address
    @view_model =  RoleViewModel.get_meeting_types_for_role(params[:role][:id]))
  end

  def save_corrected_address
    @view_model = RoleViewModel.save_corrected_address(params)
    if @view_model.saved?
      format.html { redirect_to club_get_meeting_types_for_role_path(params[:role][:id]), notice: 'Role was successfully updated.' }
      format.json { head :ok }
    else
      format.html { render action: "edit" }
      format.json { render json: @role.errors, status: :unprocessable_entity }
     end


  def save_modifications
    @view_model =  RoleViewModel.save_meeting_types(params)
  end


  # PUT /roles/1
  # PUT /roles/1.json
  def update
    #@club = current_club

    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to club_roles_path(params[:club_id]), notice: 'Role was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end


  def new
    @view_model = RoleViewModel.new_role(current_club)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role }
    end
  end





=end  

