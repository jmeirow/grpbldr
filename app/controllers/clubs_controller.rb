


class ClubsController < ApplicationController
  # GET /clubs
  # GET /clubs.json
  
   layout  'admins'
  
  
  

  # GET /clubs/1
  # GET /clubs/1.json
  def show
     
    @club = Club.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @club }
    end

   
  end
 

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id])
  end



 

  # PUT /clubs/1
  # PUT /clubs/1.json
  def update
    @club = Club.find(params[:id])

    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

 
end
