class RoleGroupAssociationsController < ApplicationController
  # GET /role_group_associations
  # GET /role_group_associations.json
  def index
    @club = current_club


    @role_group = RoleGroup.find(params[:role_group_id])
    
    # get all of the selected roles for this RoleGroup (oh, and sort them by description as well)
    @selected_roles = RoleGroup.find(params[:role_group_id]).roles.sort_by {|obj| obj.description}

    #get all the roles for the club and subtract from it all of the selected clubs. These are the available clubs.
    @available_roles = (Role.where("club_id = ?",@club) - @selected_roles).sort_by {|obj| obj.description}

    respond_to do |format|
      format.html # index.html.erb
    end
  end
 
  # PUT /role_group_associations
  # PUT /role_group_associations.json
  def replace

    @club = current_club
    
    if params["added_role_id"]
      RoleGroupAssociation.create(:role_group_id => params[:role_group_id], :role_id => params[:added_role_id], :club_id => @club.id)
    end
    if params["removed_role_id"]
      rga =  RoleGroupAssociation.where("role_group_id = ? and role_id = ? ", params[:role_group_id], params[:removed_role_id]).first
      RoleGroupAssociation.delete(rga.id)
    end

    @role_group = RoleGroup.find(params[:role_group_id])
    redirect_to club_role_group_role_group_associations_path @club,@role_group
  end


end
