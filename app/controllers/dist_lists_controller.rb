 

require './lib/view_models/dist_lists/dist_list_update_view_model.rb'

class DistListsController < ApplicationController


  layout 'admins'



  def index
    @dist_lists = DistList.where("club_id = ?", params[:club_id].to_i).order("name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dist_lists }
    end
  end

  def show
    @dist_list = DistList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dist_list }
    end
  end

  def new
    @dist_list = DistList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dist_list }
    end
  end

  def edit

    @dist_list = DistList.find(params[:id])
  end

  def create
    @dist_list = DistList.new(params[:dist_list])
    @dist_list.club_id = @club.id

    respond_to do |format|
      if @dist_list.save
        format.html { redirect_to club_dist_lists_path(@club)  , notice: 'Dist list was successfully created.' }
        format.json { render json: @dist_list, status: :created, location: @dist_list }
      else
        format.html { render action: "new" }
        format.json { render json: @dist_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @dist_list = DistList.find(params[:id])

    respond_to do |format|
      if @dist_list.update_attributes(params[:dist_list])
        format.html { redirect_to club_dist_lists_path, notice:  '  Distribution List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dist_list.errors, status: :unprocessable_entity }
      end
    end
  end


  def display_list
 
    @dist_list, @club_mbrs, @list_members, @dist_lists = DistListUpdateViewModel.get params[:dist_list_id].to_i
    respond_to do |format|
      format.html { render 'display_list'}
      format.json { render json: @dist_list }
    end
  end

  def select
    @dist_list, @club_mbrs, @list_members, @dist_lists = DistListUpdateViewModel.get params[:dist_list_id].to_i

    respond_to do |format|
      format.js  { render 'select'}
    end
  end



  def toggle

    @dist_list_member = DistListMember.where("dist_list_id = ? and member_id = ?",params[:dist_list_id], params[:member_id]).first
    if @dist_list_member
      DistListMember.delete(@dist_list_member.id)
    else
      DistListMember.create(:member_id => params[:member_id] , :dist_list_id => params[:dist_list_id])
    end
    respond_to do |format|
      format.js do
        render :layout => false
      end
    end
  end
 




  def destroy
    @dist_list = DistList.find(params[:id])
    @dist_list.destroy

    respond_to do |format|
      format.html { redirect_to club_dist_lists_url }
      format.json { head :no_content }
    end
  end


end
